FROM ruby:3.2.0

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g yarn

COPY entrypoint.sh ./
COPY entrypoint-script/wait-for-it.sh /entrypoint-script/wait-for-it.sh
COPY entrypoint-script/after-db-config.sh /entrypoint-script/after-db-config.sh

RUN chmod +x /entrypoint.sh /entrypoint-script/wait-for-it.sh /entrypoint-script/after-db-config.sh

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY package.json /app/
COPY yarn.lock /app/
RUN yarn install

COPY . /app

RUN yarn vite build

ENTRYPOINT ["/entrypoint.sh"]