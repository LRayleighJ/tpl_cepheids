.PHONY: all
all: lightcurve.png plotdata.png simu_telescope.gif 

# 绘制造父变星在一个光变周期内的光变曲线
lightcurve.png: data/fit_parameters.csv data/fourier_func.py
	python3 plot_lightcurve.py $< $@

# 根据光变周期, 并按照观测间隔时间对光变拟合曲线间隔采样
idealdata.csv: data/cepheid_info.csv data/observation_time.csv data/fit_parameters.csv 	
	python3 preluminosity.py $^ $@

# 加入抽样生成的噪声, 得到模拟数据
realdata.csv: idealdata.csv data/gauss_std.csv
	python3 add_noise.py $^ $@

# 绘制原始数据散点图
plotdata.png: realdata.csv
	python3 plot_data.py $^ $@

# 生成用来变星亮度变化的小动画 
simu_telescope.gif: realdata.csv data/cepheid_info.csv
	python3 simu_telescope.py $^ $@

# Delete partial files when the processes are killed.
.DELETE_ON_ERROR:
# # Keep intermediate files around
.SECONDARY:
