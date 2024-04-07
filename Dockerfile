FROM python:3.10-alpine
WORKDIR /opt
RUN pip3 install --upgrade pip
# Set Odoo URL environment variable
ENV ODOO_URL=http://example.com
# Set pgAdmin URL environment variable
ENV PGADMIN_URL=http://pgadmin.example.com
#ENV ODOO_URL=1
#ENV PGADMIN_URL=1
#RUN pip3 install 
EXPOSE 8080
ENTRYPOINT ["python", "src/app.py"]
