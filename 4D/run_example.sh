# conda activate dmiso
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export CUDA_VISIBLE_DEVICES=2

export data_name=lego   # trex, jumpingjacks, lego
export style_prompt=fire # fur, Wood, fire
export style_iterations=5000 # 5000(original)

echo "Started at: $(date '+%Y-%m-%d %H:%M:%S')"

# train model (stage 1)
# cd models/dmisomodel
# export PYTHONPATH=.
# # python train.py -s ../../data/trex -m ../../output/trex --batch 8 -w --iterations 80000 --is_blender
# python train.py -s /ssd_data1/projects/NeRF_Data/dnerf/${data_name}/ -m /ssd_data1/users/jypark/experiments/CLIPGaussian/${data_name} --batch 8 -w --iterations 80000 --is_blender
# # python render.py  -m ../../output/trex
# python render.py  -m /ssd_data1/users/jypark/experiments/CLIPGaussian/${data_name}

# # train objects using style (stage 2)
# cd ..
# cd ..

export PYTHONPATH=.
# python train_style.py -s data/trex -m output_style/trex  --model_output output/trex --iterations 5000 --batch 4 --style_prompt "Wood" -w
python train_style.py -s /ssd_data1/projects/NeRF_Data/dnerf/${data_name}/ -m /ssd_data1/users/jypark/experiments/CLIPGaussian/${data_name}_${style_prompt}  --model_output /ssd_data1/users/jypark/experiments/CLIPGaussian/${data_name} --iterations ${style_iterations} --batch 4 --style_prompt ${style_prompt} -w

# render style
cd models/dmisomodel
export PYTHONPATH=.
# python render.py  -m ../../output_style/trex_wood --iteration 5000
python render.py  -m /ssd_data1/users/jypark/experiments/CLIPGaussian/${data_name}_${style_prompt} --iteration ${style_iterations}