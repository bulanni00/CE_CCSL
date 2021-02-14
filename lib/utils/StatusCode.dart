// ignore: non_constant_identifier_names
YCode(m) {
  switch (m) {
    case "26":
      return '揽收入库'; //Pickup lnbound
      break;
    case '35':
      return '发货'; //Outbound
      break;
    case '30':
      return '到货'; // lnbound
      break;
    case '40':
      return '发货'; //发货已创建Planned
    case '60':
      return '派送'; //In_Transit
      break;
    case '70':
      return '派送途中'; //Delivery
      break;
    case '80':
      return '签收'; //pod
      break;
    case '85':
      return '已签收'; //Signed
      break;
    case '100':
      return '退回'; //Returned
      break;
    case '150':
      return '创建'; // Create
      break;
    default:
      return '';
      break;
  }
}
