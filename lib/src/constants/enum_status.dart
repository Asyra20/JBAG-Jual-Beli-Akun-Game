enum StatusPembayaran {
  belumBayar,
  sudahBayar,
}

enum StatusAkun {
  tersedia,
  pending,
  terjual,
}

// Utility to convert enums to SQL-like strings
String statusPembayaranToSql(StatusPembayaran status) {
  switch (status) {
    case StatusPembayaran.belumBayar:
      return 'belum_bayar';
    case StatusPembayaran.sudahBayar:
      return 'sudah_bayar';
    default:
      return '';
  }
}

String statusAkunToSql(StatusAkun status) {
  switch (status) {
    case StatusAkun.tersedia:
      return 'tersedia';
    case StatusAkun.pending:
      return 'pending';
    case StatusAkun.terjual:
      return 'terjual';
    default:
      return '';
  }
}
