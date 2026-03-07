/**
 * device-key.js
 * Gera a chave identificadora do dispositivo atual.
 * Usada para associar tokens FCM a dispositivos específicos no Firestore.
 */

/**
 * Retorna uma string identificadora estável para o dispositivo atual.
 * Formato: `{so}_{navegador}_{fab}_{modelo}` (Android com fabricante detectável)
 *       ou `{so}_{navegador}_{largura}_{altura}` (demais plataformas)
 * @returns {string}
 */
export function chaveDispositivoAtual() {
  const ua = navigator.userAgent;
  const _n = s => (s || 'desconhecido').toLowerCase().replace(/[^a-z0-9]/g, '');

  let so = 'Desconhecido';
  if (/android/i.test(ua)) so = 'Android';
  else if (/iPad|iPhone|iPod/.test(ua)) so = 'iOS';
  else if (/Windows/.test(ua)) so = 'Windows';
  else if (/Macintosh|Mac OS X/.test(ua)) so = 'macOS';
  else if (/Linux/.test(ua)) so = 'Linux';

  let nav = 'Desconhecido';
  if (ua.includes('Edg/')) nav = 'Edge';
  else if (ua.includes('Chrome/')) nav = 'Chrome';
  else if (ua.includes('Safari/') && !ua.includes('Chrome')) nav = 'Safari';
  else if (ua.includes('Firefox/')) nav = 'Firefox';

  let fab = 'Desconhecido', mod = 'Desconhecido';
  if (so === 'Android') {
    if (ua.includes('Samsung')) fab = 'Samsung';
    else if (ua.includes('Xiaomi') || ua.includes('Mi ') || ua.includes('Redmi')) fab = 'Xiaomi';
    else if (ua.includes('Motorola') || ua.includes('Moto')) fab = 'Motorola';
    else if (ua.includes('LG')) fab = 'LG';
    else if (ua.includes('Huawei') || ua.includes('HUAWEI')) fab = 'Huawei';
    else if (ua.includes('ASUS')) fab = 'Asus';
    else if (ua.includes('OnePlus')) fab = 'OnePlus';
    const modelMatch = ua.match(/\(Linux; Android [^;]+; ([^)]+)\)/);
    if (modelMatch) mod = modelMatch[1].replace(/Build.*/, '').trim();
  }

  const fnFab = _n(fab), fnMod = _n(mod);
  return (fnFab !== 'desconhecido' || fnMod !== 'desconhecido')
    ? `${_n(so)}_${_n(nav)}_${fnFab}_${fnMod}`
    : `${_n(so)}_${_n(nav)}_${`${screen.width}x${screen.height}`.replace('x', '_')}`;
}
