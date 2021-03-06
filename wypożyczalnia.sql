
create table carModel(
    idCarModel int,
    mark varchar(20) not null,
    model varchar(20) not null,
    productionYear int not null,
    reviewInterval int not null,
    
    primary key (idCarModel)
);

create table car(
    idCar int,
    carModelId int not null,
    registartionDate date not null,
    plateNr varchar(10) not null,
    pricePerDay numeric(10,2) not null,
    vin varchar(20) not null,
    
    primary key (idCar),
    constraint FK_car_carModel foreign key (carModelId) references carModel(idCarModel)
);

create table review(
    idReview int,
    carId int not null,
    counterState int not null,
    reviewDate date not null,

    primary key (idReview),
    constraint FK_car_review foreign key (carId) references car(idCar)
);


create table rentPoint(
    idRentPoint int,
    name varchar(50) not null,
    addres varchar(50) not null,
    postCode varchar(20) not null,
    city varchar(20) not null,
    
    primary key (idRentPoint)
);

create table employee(
    idEmployee int,
    firstname varchar(50) not null,
    surname varchar(50) not null,
    rentPointId int not null,
    
    primary key (idEmployee),
    constraint FK_rentPoint_employee foreign key (rentPointId) references rentPoint(idrentpoint)
);

create table client(
    idClient int,
    name varchar(50) not null,
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
    name varchar(50) not null,
    discountPercentange numeric(4,4) not null,
    carId int,
    clientId int,
    promoStart date not null,
    promoEnd date not null,
    
    primary key (idPromotion),
    constraint FK_car_promotion foreign key (carId) references car(idCar),
    constraint FK_client_promotion foreign key (clientId) references client(idClient)
);

create table rent(
    idRent int,
    carId int not null,
    clientId int not null,
    promotionId int,
    rentPointIdStart int not null,
    rentTimeStart timestamp not null,
    employeeIdStart int not null,
    counterStateStart int not null,
    notes varchar(2000) not null,
    
    primary key (idRent),
    constraint FK_car_rent foreign key (carId) references car(idCar),
    constraint FK_client_rent foreign key (clientId) references client(idClient),
    constraint FK_promotion_rent foreign key (promotionId) references promotion(idPromotion),
    constraint FK_rentPoint_rent foreign key (rentPointIdStart) references rentPoint(idRentPoint),
    constraint FK_employee_rent foreign key (employeeIdStart) references employee(idEmployee)
);

create table rentHistory(
    idRent int,
    carId int not null,
    clientId int not null,
    promotionId int,
    rentPointIdStart int not null,
    rentTimeStart timestamp not null,
    employeeIdStart int not null,
    counterStateStart int not null,
    notesStart varchar(2000) not null,
    
    rentPointIdEnd int not null,
    rentTimeEnd timestamp not null,
    employeeIdEnd int not null,
    counterStateEnd int not null,
    notesEnd varchar(2000) not null,

    primary key (idRent),
    constraint FK_car_rentHistory foreign key (carId) references car(idCar),
    constraint FK_client_rentHistory foreign key (clientId) references client(idClient),
    constraint FK_promotion_rentHistory foreign key (promotionId) references promotion(idPromotion),
    constraint FK_rentPointStart_rentHistory foreign key (rentPointIdStart) references rentPoint(idRentPoint),
    constraint FK_employeeStart_rentHistory foreign key (employeeIdStart) references employee(idEmployee),
    constraint FK_rentPointEnd_rentHistory foreign key (rentPointIdEnd) references rentPoint(idRentPoint),
    constraint FK_employeeEnd_rentHistor foreign key (employeeIdEnd) references employee(idEmployee)
);


create table invoice(
    idInvoice int,
    rentId int not null,
    invoiceNumber varchar(20) not null,
    invoiceValue number(10, 2) not null,
    invoiceDate timestamp not null,
    
    primary key (idinvoice),
    constraint FK_rentHistory_invoice foreign key (rentId) references rentHistory(idRent)
);

