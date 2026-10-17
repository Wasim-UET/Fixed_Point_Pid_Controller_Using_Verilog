`timescale 1ns / 1ps
module pid_controller_tb;

// Testbench signals
reg clk;
reg rst_n;
reg signed [15:0] setpoint;
reg signed [15:0] feedback;
reg [7:0] Kp;
reg [7:0] Ki;
reg [7:0] Kd;
wire [7:0] pwm_duty_out;

// Instantiate Unit Under Test (UUT)
pid_controller uut (
    .clk(clk),
    .rst_n(rst_n),
    .setpoint(setpoint),
    .feedback(feedback),
    .Kp(Kp),
    .Ki(Ki),
    .Kd(Kd),
    .pwm_duty_out(pwm_duty_out)
);

// Clock generation (100MHz - 10ns period)
always #5 clk = ~clk;

initial begin
    // Setup waveform dumping for EPWave / ChipVerify
    $dumpfile("dump.vcd");
    $dumpvars(0, pid_controller_tb);
    
    // Initialize Inputs
    clk = 0;
    rst_n = 0;
    setpoint = 0;
    feedback = 0;
    
    // Tuning constants
    Kp = 8'd50;
    Ki = 8'd5;
    Kd = 8'd10;
    
    // Hold reset condition
    #100;
    rst_n = 1;

    // Monitor prints output in log window
    $monitor("Time=%0dns | Setpoint=%d | Feedback=%d | PWM Out=%d", $time, setpoint, feedback, pwm_duty_out);

    // --- TEST SCENARIO: Ramping up to target ---
    setpoint = 16'd500;

    #200 feedback = 16'd100;
    #200 feedback = 16'd200;
    #200 feedback = 16'd300;
    #200 feedback = 16'd400;
    #200 feedback = 16'd480;
    #200 feedback = 16'd500;
    #200 feedback = 16'd500;
    #200 feedback = 16'd505; // Minor overshoot simulation
    #200 feedback = 16'd500;
    #200;

    $display("PID Simulation Completed.");
    $finish;
end

endmodule
