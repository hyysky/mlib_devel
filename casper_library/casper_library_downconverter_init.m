function casper_library_downconverter_init()

	warning off Simulink:Engine:MdlFileShadowing;
	mdl = new_system('casper_library_downconverter', 'Library');
	blk = get(mdl,'Name');
	warning on Simulink:Engine:MdlFileShadowing;

	add_block('built-in/SubSystem', [blk,'/mixer']);
	mixer_gen([blk,'/mixer']);
	set_param([blk,'/mixer'], ...
		'freq_div', sprintf('2'), ...
		'freq', sprintf('2'), ...
		'nstreams', sprintf('0'), ...
		'n_bits', sprintf('4'), ...
		'bram_latency', sprintf('2'), ...
		'mult_latency', sprintf('4'), ...
		'Position', sprintf('[15 30 80 120]'));

	add_block('built-in/SubSystem', [blk,'/sincos']);
	sincos_gen([blk,'/sincos']);
	set_param([blk,'/sincos'], ...
		'func', sprintf('sine and cosine'), ...
		'neg_sin', sprintf('off'), ...
		'neg_cos', sprintf('off'), ...
		'symmetric', sprintf('on'), ...
		'handle_sync', sprintf('off'), ...
		'depth_bits', sprintf('0'), ...
		'bit_width', sprintf('16'), ...
		'bram_latency', sprintf('2'), ...
		'Position', sprintf('[102 26 157 64]'));

	add_block('built-in/SubSystem', [blk,'/cosin']);
	cosin_gen([blk,'/cosin']);
	set_param([blk,'/cosin'], ...
		'output0', sprintf('cos'), ...
		'output1', sprintf('-sin'), ...
		'phase', sprintf('0'), ...
		'fraction', sprintf('0'), ...
		'store', sprintf('0'), ...
		'table_bits', sprintf('0'), ...
		'n_bits', sprintf('18'), ...
		'bin_pt', sprintf('17'), ...
		'bram_latency', sprintf('1'), ...
		'add_latency', sprintf('1'), ...
		'mux_latency', sprintf('1'), ...
		'neg_latency', sprintf('1'), ...
		'conv_latency', sprintf('2'), ...
		'pack', sprintf('off'), ...
		'bram', sprintf('BRAM'), ...
		'misc', sprintf('off'), ...
		'Position', sprintf('[175 27 230 63]'));

	add_block('built-in/SubSystem', [blk,'/dec_fir']);
	dec_fir_gen([blk,'/dec_fir']);
	set_param([blk,'/dec_fir'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'n_bits', sprintf('8'), ...
		'quantization', sprintf('Round  (unbiased: +/- Inf)'), ...
		'add_latency', sprintf('1'), ...
		'mult_latency', sprintf('2'), ...
		'conv_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'absorb_adders', sprintf('on'), ...
		'adder_imp', sprintf('DSP48'), ...
		'Position', sprintf('[15 215 80 308]'));

	add_block('built-in/SubSystem', [blk,'/lo_osc']);
	lo_osc_gen([blk,'/lo_osc']);
	set_param([blk,'/lo_osc'], ...
		'n_bits', sprintf('0'), ...
		'counter_step', sprintf('3'), ...
		'counter_start', sprintf('4'), ...
		'counter_width', sprintf('4'), ...
		'latency', sprintf('2'), ...
		'Position', sprintf('[248 26 288 81]'));

	add_block('built-in/SubSystem', [blk,'/fir_tap']);
	fir_tap_gen([blk,'/fir_tap']);
	set_param([blk,'/fir_tap'], ...
		'factor', sprintf('1'), ...
		'latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('0'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'Position', sprintf('[100 215 150 282]'));

	add_block('built-in/SubSystem', [blk,'/fir_dbl_tap']);
	fir_dbl_tap_gen([blk,'/fir_dbl_tap']);
	set_param([blk,'/fir_dbl_tap'], ...
		'factor', sprintf('0.073384000000000004781952611665474'), ...
		'add_latency', sprintf('1'), ...
		'mult_latency', sprintf('2'), ...
		'coeff_bit_width', sprintf('0'), ...
		'coeff_bin_pt', sprintf('17'), ...
		'Position', sprintf('[172 215 222 282]'));

	add_block('built-in/SubSystem', [blk,'/lo_const']);
	lo_const_gen([blk,'/lo_const']);
	set_param([blk,'/lo_const'], ...
		'n_bits', sprintf('0'), ...
		'phase', sprintf('0'), ...
		'Position', sprintf('[306 26 346 81]'));

	add_block('built-in/SubSystem', [blk,'/fir_dbl_col']);
	fir_dbl_col_gen([blk,'/fir_dbl_col']);
	set_param([blk,'/fir_dbl_col'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'add_latency', sprintf('2'), ...
		'mult_latency', sprintf('3'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'first_stage_hdl', sprintf('off'), ...
		'adder_imp', sprintf('Fabric'), ...
		'Position', sprintf('[244 215 279 330]'));

	add_block('built-in/SubSystem', [blk,'/dds']);
	dds_gen([blk,'/dds']);
	set_param([blk,'/dds'], ...
		'freq_div', sprintf('4'), ...
		'freq', sprintf('1'), ...
		'num_lo', sprintf('0'), ...
		'n_bits', sprintf('8'), ...
		'latency', sprintf('2'), ...
		'Position', sprintf('[364 25 404 80]'));

	add_block('built-in/SubSystem', [blk,'/fir_col']);
	fir_col_gen([blk,'/fir_col']);
	set_param([blk,'/fir_col'], ...
		'n_inputs', sprintf('0'), ...
		'coeff', sprintf('0.10000000000000000555111512312578'), ...
		'add_latency', sprintf('2'), ...
		'mult_latency', sprintf('3'), ...
		'coeff_bit_width', sprintf('25'), ...
		'coeff_bin_pt', sprintf('24'), ...
		'first_stage_hdl', sprintf('off'), ...
		'adder_imp', sprintf('Fabric'), ...
		'Position', sprintf('[301 215 336 330]'));

	add_block('built-in/SubSystem', [blk,'/rcmult']);
	rcmult_gen([blk,'/rcmult']);
	set_param([blk,'/rcmult'], ...
		'latency', sprintf('0'), ...
		'Position', sprintf('[422 26 462 81]'));

	set_param(blk, ...
		'Name', sprintf('casper_library_downconverter'), ...
		'LibraryType', sprintf('BlockLibrary'), ...
		'Lock', sprintf('off'), ...
		'PreSaveFcn', sprintf('mdl2m(gcs);'), ...
		'SolverName', sprintf('ode45'), ...
		'SolverMode', sprintf('SingleTasking'), ...
		'StartTime', sprintf('0.0'), ...
		'StopTime', sprintf('10.0'));
	save_system(mdl,[getenv('MLIB_DEVEL_PATH'), '/casper_library/', 'casper_library_downconverter']);
end % casper_library_downconverter_init

function mixer_gen(blk)

	mixer_mask(blk);
	mixer_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('mixer_init(gcb, ...\n    ''freq_div'', freq_div, ...\n    ''freq'', freq, ...\n    ''nstreams'', nstreams, ...\n    ''n_bits'', n_bits, ...\n    ''bram_latency'', bram_latency, ...\n    ''mult_latency'', mult_latency);\n'));

end % mixer_gen

function mixer_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('mixer'), ...
		'MaskDescription', sprintf('Digitally mixes an input signal (which can be several samples in parallel) with an LO of the indicated frequency (which is some fraction of the native FPGA clock rate).'), ...
		'MaskPromptString', sprintf('Frequency Divisions (M)|Mixing Frequency (? / M*2pi)|Number of Parallel Streams|Bit Width|BRAM Latency|Mult Latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('|||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('freq_div=@1;freq=@2;nstreams=@3;n_bits=@4;bram_latency=@5;mult_latency=@6;'), ...
		'MaskValueString', sprintf('2|2|0|4|2|4'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % mixer_mask

function mixer_init(blk)

end % mixer_init

function sincos_gen(blk)

	sincos_mask(blk);
	sincos_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('sincos_init(gcb, ...\n    ''func'', func, ...\n    ''neg_sin'', neg_sin, ...\n    ''neg_cos'', neg_cos, ...\n    ''symmetric'', symmetric, ...\n    ''handle_sync'', handle_sync, ...\n    ''depth_bits'', depth_bits, ...\n    ''bit_width'', bit_width, ...\n    ''bram_latency'', bram_latency);'));

end % sincos_gen

function sincos_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('off'), ...
		'MaskType', sprintf('sincos'), ...
		'MaskPromptString', sprintf('Function|Negative sine|Negative cosine|Symmetric output|Handle sync|Lookup table depth (2^?)|Output bit width|BRAM latency'), ...
		'MaskStyleString', sprintf('popup(cosine|sine|sine and cosine),checkbox,checkbox,checkbox,checkbox,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('|||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('func=&1;neg_sin=&2;neg_cos=&3;symmetric=&4;handle_sync=&5;depth_bits=@6;bit_width=@7;bram_latency=@8;'), ...
		'MaskValueString', sprintf('sine and cosine|off|off|on|off|0|16|2'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % sincos_mask

function sincos_init(blk)

end % sincos_init

function cosin_gen(blk)

	cosin_mask(blk);
	cosin_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('cosin_init(gcb, ...\n    ''output0'', output0, ...    \n    ''output1'', output1, ...\n    ''phase'', phase, ...\n    ''fraction'', fraction, ...\n    ''table_bits'', table_bits, ...  \n    ''n_bits'', n_bits, ...      \n    ''bin_pt'', bin_pt, ...     \n    ''bram_latency'', bram_latency, ...\n    ''add_latency'', add_latency, ...\n    ''mux_latency'', mux_latency, ...\n    ''neg_latency'', neg_latency, ...\n    ''conv_latency'', conv_latency, ...\n    ''store'', store, ...\n    ''pack'', pack, ...\n    ''bram'', bram, ...\n    ''misc'', misc);\n'));

end % cosin_gen

function cosin_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('cosin'), ...
		'MaskPromptString', sprintf('first output function|second output function|initial phase offset ((2*pi)/2^?)|fraction of cycle period to output (1/2^?)|fraction of cycle period to store (1/2^?)|samples in period to output (2^?)|bit width|binary point|bram latency|large adder latency|mux latency|negate latency|convert latency|pack lookup values in same output word|BRAM implementation|Miscellaneous port'), ...
		'MaskStyleString', sprintf('popup(sin|cos|-sin|-cos),popup(none|sin|cos|-sin|-cos),edit,edit,edit,edit,edit,edit,edit,edit,edit,edit,edit,checkbox,popup(distributed RAM|BRAM),checkbox'), ...
		'MaskTabNameString', sprintf('basic,basic,basic,basic,implementation,basic,basic,basic,latency,latency,latency,latency,latency,implementation,implementation,implementation'), ...
		'MaskCallbackString', sprintf('|||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('output0=&1;output1=&2;phase=@3;fraction=@4;store=@5;table_bits=@6;n_bits=@7;bin_pt=@8;bram_latency=@9;add_latency=@10;mux_latency=@11;neg_latency=@12;conv_latency=@13;pack=&14;bram=&15;misc=&16;'), ...
		'MaskValueString', sprintf('cos|-sin|0|0|0|0|18|17|1|1|1|1|2|off|BRAM|off'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'), ...
		'MaskDisplay', sprintf('if ~(table_bits == 0),\n        color(''black'');port_label(''output'',1,output0);\n    color(''black'');port_label(''output'',2,output1);\n    color(''black'');disp([''z^{-'',num2str(add_latency+mux_latency+conv_latency+bram_latency+neg_latency+mux_latency),''}''],''texmode'',''on'');color(''black'');port_label(''input'',1,''theta'');\n    if strcmp(misc, ''on''),\n        color(''black'');port_label(''input'',2,''misci'');\n        color(''black'');port_label(''output'',3,''misco'');\n    end\nend'));

end % cosin_mask

function cosin_init(blk)

end % cosin_init

function dec_fir_gen(blk)

	dec_fir_mask(blk);
	dec_fir_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('dec_fir_init(gcb, ...\n    ''n_inputs'', n_inputs, ...\n    ''coeff'', coeff, ...\n    ''n_bits'', n_bits, ...\n    ''quantization'', quantization, ...\n    ''add_latency'', add_latency, ...\n    ''mult_latency'', mult_latency, ...\n    ''conv_latency'', conv_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt, ...\n    ''absorb_adders'', absorb_adders, ...\n    ''adder_imp'', adder_imp);'));

end % dec_fir_gen

function dec_fir_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('dec_fir'), ...
		'MaskDescription', sprintf('FIR filter which can handle multiple time samples in parallel and decimates down to 1 time sample.  If coefficients are symmetric, will automatically fold before multiplying.'), ...
		'MaskPromptString', sprintf('Number of Parallel Streams|Coefficients|Bit Width Out|Quantization Behavior|Add Latency|Mult Latency|Convert latency|Coefficient bit width|Coefficient binary point|Absorb adders into DSP slices|Adder implementation'), ...
		'MaskStyleString', sprintf('edit,edit,edit,popup(Truncate|Round  (unbiased: +/- Inf)|Round  (unbiased: Even Values)),edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48)'), ...
		'MaskCallbackString', sprintf('||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;n_bits=@3;quantization=&4;add_latency=@5;mult_latency=@6;conv_latency=@7;coeff_bit_width=@8;coeff_bin_pt=@9;absorb_adders=&10;adder_imp=&11;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|8|Round  (unbiased: +/- Inf)|1|2|2|25|24|on|DSP48'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % dec_fir_mask

function dec_fir_init(blk)

end % dec_fir_init

function lo_osc_gen(blk)

	lo_osc_mask(blk);
	lo_osc_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('lo_osc_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''counter_step'', counter_step, ...\n    ''counter_start'', counter_start, ...\n    ''counter_width'', counter_width, ...\n    ''latency'', latency);'));

end % lo_osc_gen

function lo_osc_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('lo_osc'), ...
		'MaskDescription', sprintf('Generates -sin and cos data using a look-up \ntable. '), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Lo_osc'''')'')'), ...
		'MaskPromptString', sprintf('Output Bitwidth|counter step|counter start value|Counter Bitwidth|Lookup latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;counter_step=@2;counter_start=@3;counter_width=@4;latency=@5;'), ...
		'MaskValueString', sprintf('0|3|4|4|2'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % lo_osc_mask

function lo_osc_init(blk)

end % lo_osc_init

function fir_tap_gen(blk)

	fir_tap_mask(blk);
	fir_tap_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_tap_init(gcb, ...\n    ''factor'', factor, ...\n    ''latency'', latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt);'));

end % fir_tap_gen

function fir_tap_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_tap'), ...
		'MaskDescription', sprintf('Multiplies input data with factor specified.'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_tap'''')'')'), ...
		'MaskPromptString', sprintf('Factor|Mult latency|Coefficient bit width|Coefficient binary point'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('|||'), ...
		'MaskEnableString', sprintf('on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on'), ...
		'MaskVariables', sprintf('factor=@1;latency=@2;coeff_bit_width=@3;coeff_bin_pt=@4;'), ...
		'MaskValueString', sprintf('1|2|0|24'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % fir_tap_mask

function fir_tap_init(blk)

end % fir_tap_init

function fir_dbl_tap_gen(blk)

	fir_dbl_tap_mask(blk);
	fir_dbl_tap_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_dbl_tap_init(gcb, ...\n    ''factor'', factor, ...\n    ''add_latency'', add_latency, ...\n    ''mult_latency'', mult_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt);'));

end % fir_dbl_tap_gen

function fir_dbl_tap_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_dbl_tap'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_dbl_tap'''')'')'), ...
		'MaskPromptString', sprintf('factor|Add latency|Mult latency|Coefficient bit width|Coefficient binary point '), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('factor=@1;add_latency=@2;mult_latency=@3;coeff_bit_width=@4;coeff_bin_pt=@5;'), ...
		'MaskValueString', sprintf('0.073384000000000004781952611665474|1|2|0|17'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % fir_dbl_tap_mask

function fir_dbl_tap_init(blk)

end % fir_dbl_tap_init

function lo_const_gen(blk)

	lo_const_mask(blk);
	lo_const_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('lo_const_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''phase'', phase);'));

end % lo_const_gen

function lo_const_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('lo_const'), ...
		'MaskDescription', sprintf('Generates a complex constant associated with the \nphase supplied as a parameter.'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Lo_const'''')'')'), ...
		'MaskPromptString', sprintf('Output Bitwidth|Phase (0 to 2*pi)'), ...
		'MaskStyleString', sprintf('edit,edit'), ...
		'MaskCallbackString', sprintf('|'), ...
		'MaskEnableString', sprintf('on,on'), ...
		'MaskVisibilityString', sprintf('on,on'), ...
		'MaskToolTipString', sprintf('on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;phase=@2;'), ...
		'MaskValueString', sprintf('0|0'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % lo_const_mask

function lo_const_init(blk)

end % lo_const_init

function fir_dbl_col_gen(blk)

	fir_dbl_col_mask(blk);
	fir_dbl_col_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_dbl_col_init(gcb, ...\n    ''n_inputs'', n_inputs, ...\n    ''coeff'', coeff, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt,  ...\n    ''first_stage_hdl'', first_stage_hdl, ...\n    ''adder_imp'', adder_imp);'));

end % fir_dbl_col_gen

function fir_dbl_col_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_dbl_col'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_dbl_col'''')'')'), ...
		'MaskPromptString', sprintf('Inputs|Coefficients|Add latency|Mult Latency|Coefficient bit width|Coefficient binary point|Implement first stage of adder trees on output as behavioural HDL|Adder implementation'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48)'), ...
		'MaskCallbackString', sprintf('|||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;add_latency=@3;mult_latency=@4;coeff_bit_width=@5;coeff_bin_pt=@6;first_stage_hdl=&7;adder_imp=&8;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|2|3|25|24|off|Fabric'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % fir_dbl_col_mask

function fir_dbl_col_init(blk)

end % fir_dbl_col_init

function dds_gen(blk)

	dds_mask(blk);
	dds_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('dds_init(gcb, ...\n    ''freq_div'', freq_div, ...\n    ''freq'', freq, ...\n    ''num_lo'', num_lo, ...\n    ''n_bits'', n_bits, ...\n    ''latency'', latency);'));

end % dds_gen

function dds_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('dds'), ...
		'MaskDescription', sprintf('Generates P channels of sin and cos data for mixing\nwith input data in a DDC. To generate frequency \nN/M(Fc x P) (where Fc is the clock rate) \nM = "Frequency Divisions", N = "Frequency",\nParallel LOs = P'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Dds'''')'')'), ...
		'MaskPromptString', sprintf('Frequency divisions (M)|Frequency (? / M*2pi)|Parallel LOs|Bit Width|Latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('freq_div=@1;freq=@2;num_lo=@3;n_bits=@4;latency=@5;'), ...
		'MaskValueString', sprintf('4|1|0|8|2'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % dds_mask

function dds_init(blk)

end % dds_init

function fir_col_gen(blk)

	fir_col_mask(blk);
	fir_col_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('fir_col_init(gcb, ...\n    ''n_inputs'', n_inputs,...\n    ''coeff'', coeff, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''coeff_bit_width'', coeff_bit_width, ...\n    ''coeff_bin_pt'', coeff_bin_pt, ...\n    ''first_stage_hdl'', first_stage_hdl, ...\n    ''adder_imp'', adder_imp);'));

end % fir_col_gen

function fir_col_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('fir_col'), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Fir_col'''')'')'), ...
		'MaskPromptString', sprintf('Inputs|Coefficients|Add latency|Mult Latency|Coefficient bit width|Coefficient binary point|Implement first stage of adder trees on output as behavioural HDL|Adder implementation'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,popup(Behavioral|Fabric|DSP48)'), ...
		'MaskCallbackString', sprintf('|||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_inputs=@1;coeff=@2;add_latency=@3;mult_latency=@4;coeff_bit_width=@5;coeff_bin_pt=@6;first_stage_hdl=&7;adder_imp=&8;'), ...
		'MaskValueString', sprintf('0|0.10000000000000000555111512312578|2|3|25|24|off|Fabric'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % fir_col_mask

function fir_col_init(blk)

end % fir_col_init

function rcmult_gen(blk)

	rcmult_mask(blk);
	rcmult_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('rcmult_init(gcb, ...\n    ''latency'', latency);'));

end % rcmult_gen

function rcmult_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('rcmult'), ...
		'MaskDescription', sprintf('Multiplies input data with cos and sin inputs and\noutputs results on real and imag ports \nrespectively. '), ...
		'MaskHelp', sprintf('eval(''xlWeb(''''http://casper.berkeley.edu/wiki/Rcmult'''')'')'), ...
		'MaskPromptString', sprintf('Multiplier latency'), ...
		'MaskStyleString', sprintf('edit'), ...
		'MaskEnableString', sprintf('on'), ...
		'MaskVisibilityString', sprintf('on'), ...
		'MaskToolTipString', sprintf('on'), ...
		'MaskVariables', sprintf('latency=@1;'), ...
		'MaskValueString', sprintf('0'), ...
		'BackgroundColor', sprintf('[0.501961, 0.501961, 0.501961]'));

end % rcmult_mask

function rcmult_init(blk)

end % rcmult_init

