package com.iwe.avenger.dao;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;

public class DynamoDBManager {

   private static DynamoDBMapper mapper;

   static {

       final AmazonDynamoDB ddb = AmazonDynamoDBClientBuilder.standard().withRegion(Regions.US_EAST_1).build();

       mapper = new DynamoDBMapper(ddb);
   }

   public static DynamoDBMapper mapper() {
       return DynamoDBManager.mapper;
   }

}
////Implementar o acesso aos dados na classe AvengersDAO
//
//   private static final DynamoDBMapper mapper = DynamoDBManager.mapper();
//
//   public Optional<Avenger> search(final String id) {
//       final Avenger avenger = mapper.load(Avenger.class, id);
//       return Optional.ofNullable(avenger);
//   }
//
//   public Avenger save(final Avenger avenger) {
//       mapper.save(avenger);
//       return avenger;
//   }
//
//   public void delete(Avenger input) {
//       mapper.delete(input);
//   }}