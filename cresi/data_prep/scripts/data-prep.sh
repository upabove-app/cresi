# run this from the /workspace/data_prep that is mapped from the docker run command

python create_8bit_images.py \
--input=/data/sn3.upabove.aegean.ai/AOI_4_Shanghai/PS-MS \
--outdir=/data/sn3.upabove.aegean.ai/cresi_data/8bit/PS-RGB \
--rescale_type=perc \
--percentiles=2,98 \
--band_order=5,3,2

python speed_masks.py  \
--geojson_dir=/data/sn3.upabove.aegean.ai/AOI_4_Shanghai/geojson_roads \
--image_dir=/data/sn3.upabove.aegean.ai/AOI_4_Shanghai/PS-MS \
--output_conversion_csv_contin=/data/sn3.upabove.aegean.ai/cresi_data/cresi_train/SN3_roads_train_speed_conversion_continuous.csv \
--output_mask_dir_contin=/data/sn3.upabove.aegean.ai/cresi_data/cresi_train/train_mask_continuous \
--buffer_distance_meters=2 \
--label_type=SN3
