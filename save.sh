#!/bin/bash

echo "Saving world data..."

# 配置 git（如果尚未配置）
git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"

# 检查是否有更改
cd /minecraft
if [ -d .git ]; then
    # 添加所有更改的文件
    git add world/ logs/ *.json *.txt server.properties 2>/dev/null || true

    # 检查是否有需要提交的更改
    if ! git diff --cached --quiet 2>/dev/null; then
        # 提交更改
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        git commit -m "auto-save: $TIMESTAMP" || true

        # 推送到远程仓库（如果配置了远程）
        if git remote | grep -q origin; then
            git push origin main 2>/dev/null || echo "Failed to push changes"
        fi
    else
        echo "No changes to save"
    fi
else
    echo "Not a git repository, skipping save"
fi

echo "Save complete"