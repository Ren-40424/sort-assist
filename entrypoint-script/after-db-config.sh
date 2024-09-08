#!/usr/bin/env bash
rm -f tmp/pids/server.pid

retry_count=0
max_retries=5

while [ "$retry_count" -lt "$max_retries" ]; do
  version=$(rails db:version | grep -o '[0-9]\+')
  
  if [ -n "$version" ] && [ "$version" -gt 0 ]; then
    break
  else
    echo "Creating database or applying migrations..."
    rails db:create
    rails db:migrate
  fi
  
  version=$(rails db:version | grep -o '[0-9]\+')
  if [ -z "$version" ] || [ "$version" -eq 0 ]; then
    echo "Failed to initialize database, retrying in 15 seconds... (Attempt $((retry_count+1))/$max_retries)"
    sleep 15
    retry_count=$((retry_count + 1))
  else
    break
  fi
done

if [ "$retry_count" -ge "$max_retries" ]; then
  echo "Max retries reached, failed to initialize the database."
  exit 1
fi

rails s -p 3000 -b '0.0.0.0'