# https://diagrams.mingrammer.com
from diagrams import Cluster, Diagram
from diagrams.aws.compute import EC2
from diagrams.aws.analytics import ManagedStreamingForKafka
from diagrams.aws.analytics import Glue, GlueCrawlers, GlueDataCatalog, Redshift
from diagrams.generic.compute import Rack
from diagrams.onprem.iac import Terraform, Ansible

graph_attr = {
    "fontsize": "45",
    "pad": "0"
}

with Diagram("Infrastructure", graph_attr=graph_attr):
    with Cluster("AWS Cloud"):
        ec2_nifi = EC2("NiFi")

        with Cluster("K afka Cluster"):
            kafka_cluster = [
                ManagedStreamingForKafka("Broker 0"),
                ManagedStreamingForKafka("Broker 1")
            ]

        with Cluster("Redshift"):
            redshift_cluster = [
                Redshift("Node 0")
            ]

        with Cluster("Glue"):
            glue_job = Glue("Glue Job")

            with Cluster("Kafka Connection", direction="LR"):
                glue_msk_crawler = GlueCrawlers("MSK Crawler") 
                glue_msk_catalog = GlueDataCatalog("MSK Catalog")
            
            with Cluster("Redshift Connection", direction="LR"):
                glue_redshift_catalog = GlueDataCatalog("Redshift Catalog") 
                glue_redshift_crawler = GlueCrawlers("Redshift Crawler")
            
            kafka_cluster << glue_msk_crawler >> glue_msk_catalog
            glue_redshift_catalog << glue_redshift_crawler >> redshift_cluster
            kafka_cluster >> glue_msk_catalog >> glue_job >> glue_redshift_catalog >> redshift_cluster

    ec2_nifi >> kafka_cluster
