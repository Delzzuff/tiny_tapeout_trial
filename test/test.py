# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 20, unit="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    # -------------------------
    # Load A = 20
    # -------------------------
    dut.ui_in.value = 20
    dut.uio_in.value = 1
    await ClockCycles(dut.clk, 1)
    dut.uio_in.value = 0

    # -------------------------
    # Load B = 30
    # -------------------------
    dut.ui_in.value = 30
    dut.uio_in.value = 2
    await ClockCycles(dut.clk, 1)
    dut.uio_in.value = 0

    # -------------------------
    # Read lower byte
    # 20 * 30 = 600 = 0x0258
    # -------------------------
    dut.uio_in.value = 3
    await ClockCycles(dut.clk, 2)
    assert int(dut.uo_out.value) == 24
    dut._log.info(f"Lower byte: {int(dut.uo_out.value)}")

    dut.uio_in.value = 0

    # -------------------------
    # Read upper byte
    # -------------------------
    dut.uio_in.value = 4
    await ClockCycles(dut.clk, 2)
    assert int(dut.uo_out.value) == 2
    dut._log.info(f"Upper byte: {int(dut.uo_out.value)}")

    dut.uio_in.value = 0

    # Set the input values you want to test
    # dut.ui_in.value = 20
    # dut.uio_in.value = 1
    # await ClockCycles(dut.clk, 1)
    # dut.ui_in.value = 30
    # dut.uio_in.value = 2
    # await ClockCycles(dut.clk, 1)
    # dut.uio_in.value = 3
    # await ClockCycles(dut.clk, 1)
    # assert dut.uo_out.value == 18
    # print(dut.uo_out.value)
    # dut.uio_in.value = 4
    # # Wait for one clock cycle to see the output values
    # await ClockCycles(dut.clk, 1)
    # assert dut.uo_out.value == 2
    # print(dut.uo_out.value)
    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
