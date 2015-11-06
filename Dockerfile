FROM phusion/passenger-ruby21
ADD . /home/app
WORKDIR /home/app
RUN bundle install
RUN npm install
CMD ["ruby", "accapp.rb"]
EXPOSE 9292
