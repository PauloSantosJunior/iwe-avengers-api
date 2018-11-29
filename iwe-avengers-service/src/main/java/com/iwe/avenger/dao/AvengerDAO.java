package com.iwe.avenger.dao;

import java.util.Optional;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.lambda.runtime.Context;
import com.iwe.avenger.dynamodb.entity.Avenger;

public class AvengerDAO {
	private DynamoDBMapper mapper = DynamoDBManager.mapper();
	
	public Optional<Avenger> search(String id) {
		final Avenger avenger = mapper.load(Avenger.class, id);
		return Optional.ofNullable(avenger);
	}

	public Avenger save(Avenger newAvenger) {
		mapper.save(newAvenger);
		return newAvenger;
	}
		
	public Optional<Avenger> delete(Avenger avenger) {
		
		final Optional<Avenger> avengerRetrieved = search(avenger.getId());
		
		if ( avengerRetrieved.isPresent() )
			mapper.delete(avenger);
		
		return avengerRetrieved;
	}
	
}
