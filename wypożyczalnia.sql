create user rentAdmin IDENTIFIED BY rentPwd
;

create table carModel(
    idCarModel int,
    mark varchar(20),
    model varchar(20),
    productionYear int,
    reviewInterval int,
    
    primary key (idCarModel)
);

create table car(
    idCar int,
    carModelId int,
    registartionDate date,
    plateNr varchar(10),
    pricePerDay numeric(10,2),
    vin varchar(20),
    
    primary key (idCar),
    constraint FK_car_carModel foreign key (carModelId) references carModel(idCarModel)
);

create table review(
    idReview int,
    carId int,
    counterState int,
    reviewDate date,

    primary key (idReview),
    constraint FK_car_review foreign key (carId) references car(idCar)
);


create table rentPoint(
    idRentPoint int,
    name varchar(50),
    addres varchar(50),
    postCode varchar(20),
    city varchar(20),
    
    primary key (idRentPoint)
);

create table employee(
    idEmployee int,
    firstname varchar(50),
    surname varchar(50),
    rentPointId int,
    
    primary key (idEmployee),
    constraint FK_rentPoint_employee foreign key (rentPoint) references rentPoint(idrentpoint)
);

create table client(
    idClient int,
    name varchar(50),
    address varchar(50),
    postCode varchar(20),
    city varchar(20),
    
    taxNumber varchar(20),
    email varchar(50),
    telephoneNr varchar(20),
    
    primary key (idClient)
);

create table promotion(
    idPromotion int,
    name varchar(50),
    discountPercentange numeric(4,4),
    carId int,
    clientId int,
    promoStart date,
    promoEnd date,
    
    primary key (idPromotion),
    constraint FK_car_promotion foreign key (carId) references car(idCar),
    constraint FK_client_promotion foreign key (clientId) references client(idClient)
);

create table rent(
    idRent int,
    carId int,
    rentPointIdStart int,
    rentTimeStart timestamp,
    employeeIdStart int,
    counterStateStart int,
    notes varchar(2000),
    
    primary key (idRent),
    constraint FK_car_rent foreign key (carId) references car(idCar),
    constraint FK_rentPoint_rent foreign key (rentPointIdStart) references rentPoint(idRentPoint),
    constraint FK_employee_rent foreign key (employeeIdStart) references employee(idEmployee)
);

create table rentHistory(
    idRent int,
    carId int,
    rentPointIdStart int,
    rentTimeStart timestamp,
    employeeIdStart int,
    counterStateStart int,
    notesStart varchar(2000),
    
    rentPointIdEnd int,
    rentTimeEnd timestamp,
    employeeIdEnd int,
    counterStateEnd int,
    notesEnd varchar(2000),

    primary key (idRent),
    constraint FK_car_rentHistory foreign key (carId) references car(idCar),
    constraint FK_rentPointStart_rentHistory foreign key (rentPointIdStart) references rentPoint(idRentPoint),
    constraint FK_employeeStart_rentHistory foreign key (employeeIdStart) references employee(idEmployee),
    constraint FK_rentPointEnd_rentHistory foreign key (rentPointIdEnd) references rentPoint(idRentPoint),
    constraint FK_employeeEnd_rentHistor foreign key (employeeIdEnd) references employee(idEmployee)
);

create table rentPromotion (
    rentId int,
    promotionId int,
    
    constraint FK_rentHistory_rentPromotion foreign key (rentId) references rentHistory(idRent),
    constraint FK_promotion_rentPromotion foreign key (promotionId) references promotion(idPromotion)
);



