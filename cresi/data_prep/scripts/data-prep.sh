# run this from the /workspace/data_prep that is mapped from the docker run command

python create_8bit_images.py --input=/data/sn3.upabove.aegean.ai/AOI_4_Shanghai/PS-MS/ --outdir=/data/sn3.upabove.aegean.ai/cresi_data/8bit/PS-RGB --rescale_type=perc --percentiles=2,98 --band_order=5,3,2
