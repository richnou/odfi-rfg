

/* auto generated by RFG */
/* instantiation template
info_rf info_rf_I (
	.res_n(),
	.clk(),
	.address(),
	.read_data(),
	.invalid_address(),
	.access_complete(),
	.read_en(),
	.write_en(),
	.write_data(),
	.node_id(),
	.node_guid_next(),
	.r1_r1_1_next(),
	.r1_r1_1,
	.r1_r1_2_next(),
	.r1_r1_2,
	.r1_r1_2_written(),
	.r1_r1_3_next(),
	.r1_r1_3,
	.r1_r1_3_written(),
	.r1_r1_4_next(),
	.r1_r1_4,
	.r1_r1_4_wen(),
	.tsc_cnt_next(),
	.tsc_cnt,
	.tsc_cnt_wen(),
	.tsc_cnt_countup()

);
*/
module info_rf
(
	///\defgroup sys
	///@{ 
	input wire res_n,
	input wire clk,
	///}@ 
	///\defgroup rw_if
	///@{ 
	input wire[4:3] address,
	output reg[63:0] read_data,
	output reg invalid_address,
	output reg access_complete,
	input wire read_en,
	input wire write_en,
	input wire[63:0] write_data,
	///}@ 
	output reg[15:0] node_id,
	input wire[23:0] node_guid_next,
	input wire[15:0] r1_r1_1_next,
	output reg[15:0] r1_r1_1,
	input wire[15:0] r1_r1_2_next,
	output reg[15:0] r1_r1_2,
	output reg r1_r1_2_written,
	input wire[15:0] r1_r1_3_next,
	output reg[15:0] r1_r1_3,
	output reg r1_r1_3_written,
	input wire[15:0] r1_r1_4_next,
	output reg[15:0] r1_r1_4,
	input wire r1_r1_4_wen,
	input wire[47:0] tsc_cnt_next,
	output wire[47:0] tsc_cnt,
	input wire tsc_cnt_wen,
	input wire tsc_cnt_countup


);

	reg[31:0] driver_version;
	reg[23:0] node_guid;
	reg[15:0] node_vpids;
	reg r1_r1_3_res_in_last_cycle;
	reg tsc_cnt_load_enable;
	reg[47:0] tsc_cnt_load_value;

	counter48 #(
		.DATASIZE(48)
	) tsc_I (
		.clk(clk),
		.res_n(res_n),
		.increment(tsc_cnt_countup),
		.load(tsc_cnt_load_value),
		.load_enable(tsc_cnt_load_enable),
		.value(tsc_cnt)
	);

	/* register driver */
	`ifdef ASYNC_RES
	always @(posedge clk or negedge res_n) `else
	always @(posedge clk) `endif
	begin
		if (!res_n)
		begin
			driver_version <= 32'h12abcd;
		end
		else
		begin

		end
	end

	/* register node */
	`ifdef ASYNC_RES
	always @(posedge clk or negedge res_n) `else
	always @(posedge clk) `endif
	begin
		if (!res_n)
		begin
			node_id <= 0;
			node_guid <= 24'h12abcd;
			node_vpids <= 0;
		end
		else
		begin

			if((address[4:3]== 1) && write_en)
			begin
				node_id <= write_data[15:0];
			end
			else
			begin
				node_guid <= node_guid_next;
			end
		end
	end

	/* register r1 */
	`ifdef ASYNC_RES
	always @(posedge clk or negedge res_n) `else
	always @(posedge clk) `endif
	begin
		if (!res_n)
		begin
			r1_r1_1 <= 0;
			r1_r1_2 <= 0;
			r1_r1_2_written <= 1'b0;
			r1_r1_3 <= 0;
			r1_r1_3_written <= 1'b0;
			r1_r1_3_res_in_last_cycle <= 1'b1;
			r1_r1_4 <= 0;
		end
		else
		begin

			if((address[4:3]== 2) && write_en)
			begin
				r1_r1_1 <= write_data[15:0];
			end
			else
			begin
				r1_r1_1 <= r1_r1_1_next;
			end
			if((address[4:3]== 2) && write_en)
			begin
				r1_r1_2 <= write_data[31:16];
			end
			else
			begin
				r1_r1_2 <= r1_r1_2_next;
			end
			if((address[4:3]== 2) && write_en)
			begin
				r1_r1_2_written <= 1'b1;
			end
			else
			begin
				r1_r1_2_written <= 1'b0;
			end

			if((address[4:3]== 2) && write_en)
			begin
				r1_r1_3 <= write_data[47:32];
			end
			else
			begin
				r1_r1_3 <= r1_r1_3_next;
			end
			if(((address[4:3]== 2) && write_en) || r1_r1_3_res_in_last_cycle)
			begin
				r1_r1_3_written <= 1'b1;
				r1_r1_3_res_in_last_cycle <= 1'b0;
			end
			else
			begin
				r1_r1_3_written <= 1'b0;
			end

			if((address[4:3]== 2) && write_en)
			begin
				r1_r1_4 <= write_data[63:48];
			end
			else if(r1_r1_4_wen)
			begin
				r1_r1_4 <= r1_r1_4_next;
			end
		end
	end

	/* register tsc */
	`ifdef ASYNC_RES
	always @(posedge clk or negedge res_n) `else
	always @(posedge clk) `endif
	begin
		if (!res_n)
		begin
			tsc_cnt_load_enable <= 1'b0;
		end
		else
		begin

			if((address[4:3]== 3) && write_en)
			begin
				tsc_cnt_load_enable <= 1'b1;
				tsc_cnt_load_value <= write_data[47:0];
			end
			else if(tsc_cnt_wen)
			begin
				tsc_cnt_load_enable <= 1'b1;
				tsc_cnt_load_value <= tsc_cnt_next;
			end
			else
			begin
				tsc_cnt_load_enable <= 1'b0;
			end
		end
	end


	`ifdef ASYNC_RES
	always @(posedge clk or negedge res_n) `else
	always @(posedge clk) `endif
	begin
		if (!res_n)
		begin
			invalid_address <= 1'b0;
			access_complete <= 1'b0;
			`ifdef ASIC
			read_data   <= 64'b0;
			`endif
		end
		else
		begin
			casex(address[4:3])
				2'h0:
				begin
					read_data[31:0] <= driver_version;
					read_data[63:32] <= 32'b0;
					invalid_address <= 1'b0;
					access_complete <= write_en || read_en;
				end
				2'h1:
				begin
					read_data[15:0] <= node_id;
					read_data[39:16] <= node_guid;
					read_data[55:40] <= node_vpids;
					read_data[63:56] <= 8'b0;
					invalid_address <= 1'b0;
					access_complete <= write_en || read_en;
				end
				2'h2:
				begin
					read_data[15:0] <= r1_r1_1;
					read_data[31:16] <= r1_r1_2;
					read_data[47:32] <= r1_r1_3;
					read_data[63:48] <= r1_r1_4;
					invalid_address <= 1'b0;
					access_complete <= write_en || read_en;
				end
				2'h3:
				begin
					read_data[47:0] <= tsc_cnt;
					read_data[63:48] <= 16'b0;
					invalid_address <= 1'b0;
					access_complete <= write_en || read_en;
				end
				default:
				begin
					invalid_address <= read_en || write_en;
					access_complete <= read_en || write_en;
				end		
			endcase
		end
	end
endmodule