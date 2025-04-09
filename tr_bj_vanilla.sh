# Train Beijing dataset
# shell命令中只能用#注释

weight_save_dir=(
    "./weights_bj_vanilla_seed42"
)
models=(
    # "unet"
    # "resunet"
    # "deeplabv3+"
    # "linknet"
    # "dlink34"
    "dlink34_1d"
)
random_seed=(
    # 0
    42
    # 1234
)
for w in "${weight_save_dir[@]}"; do
    for m in "${models[@]}"; do
        for seed in "${random_seed[@]}"; do
            if [ "${m}" == "resunet" ]; then
                n=2
            else
                n=1
            fi
            # # vanilla, GPS
            # ts -G "${n}" python train.py \
            #     --model "${m}" \
            #     --weight_save_dir "${w}" \
            #     --dataset_name bj \
            #     --sat_dir '' \
            #     --mask_dir ../datasets/dataset_bj_time/train_val/mask \
            #     --test_sat_dir '' \
            #     --test_mask_dir ../datasets/dataset_bj_time/test/mask \
            #     --gps_dir ../datasets/dataset_bj_time/GPS/patch \
            #     \
            #     --gps_type data \
            #     --gps_render_type count \
            #     --quantity_render_type direct \
            #     --epochs 60 \
            #     --wandb_group "bj_vanilla" \
            #     --wandb_notes "bj, vanilla, GPS"
            # # vanilla, Satellite
            # ts -G "${n}" python train.py \
            #     --model "${m}" \
            #     --weight_save_dir "${w}" \
            #     --dataset_name bj \
            #     --sat_dir ../datasets/dataset_bj_time/train_val/image \
            #     --mask_dir ../datasets/dataset_bj_time/train_val/mask \
            #     --test_sat_dir ../datasets/dataset_bj_time/test/image_test \
            #     --test_mask_dir ../datasets/dataset_bj_time/test/mask \
            #     --gps_dir '' \
            #     \
            #     --gps_type '' \
            #     --gps_render_type '' \
            #     --quantity_render_type '' \
            #     --epochs 60 \
            #     --wandb_group "bj_vanilla" \
            #     --wandb_notes "bj, vanilla, Satellite"
            # vanilla, GPS+Satellite
            ts -G "${n}" python train.py \
                --model "${m}" \
                --random_seed "${seed}" \
                --weight_save_dir "${w}_${seed}" \
                --dataset_name bj \
                --sat_dir ../datasets/dataset_bj_time/train_val/image \
                --mask_dir ../datasets/dataset_bj_time/train_val/mask \
                --test_sat_dir ../datasets/dataset_bj_time/test/image_test \
                --test_mask_dir ../datasets/dataset_bj_time/test/mask \
                --gps_dir ../datasets/dataset_bj_time/GPS/patch \
                \
                --gps_type data \
                --gps_render_type count \
                --quantity_render_type direct \
                --epochs 60 \
                --wandb_group "bj_vanilla_no_dilation" \
                --wandb_notes "bj, vanilla, GPS+Satellite, remove dilation"
        done
    done
done
