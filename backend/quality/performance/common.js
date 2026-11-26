import http from 'k6/http';
import { check, sleep } from 'k6';
const base = 'http://127.0.0.1:3001';
export function prepare() {
  const s = http.get(`${base}/size/getsizes`);
  if (s.status !== 200 || !Array.isArray(s.json()) || s.json().length === 0) throw new Error('Start the seeded performance server first.');
  const c = http.get(`${base}/color/getcolors`);
  if (c.status !== 200 || !Array.isArray(c.json()) || c.json().length === 0) throw new Error('Missing color fixtures');
}
export function scenario() {
  for (const [path, name] of [['/size/getsizes','sizes'], ['/color/getcolors','colors']]) {
    const r = http.get(base + path, { tags: { name } });
    check(r, { [`${name}: HTTP 200`]: x => x.status === 200, [`${name}: nonempty JSON array`]: x => { try { const a=x.json(); return Array.isArray(a) && a.length>0; } catch (_) { return false; } } });
  }
  sleep(1);
}
export function summary(data, name) {
  const m=data.metrics;
  const lines=['Bridgewear '+name, 'Requests: '+m.http_reqs.values.count, 'Requests/s: '+m.http_reqs.values.rate, 'Average ms: '+m.http_req_duration.values.avg, 'P95 ms: '+m.http_req_duration.values['p(95)'], 'P99 ms: '+m.http_req_duration.values['p(99)'], 'Failed request rate: '+m.http_req_failed.values.rate, 'Check success rate: '+m.checks.values.rate, 'Thresholds: '+JSON.stringify(Object.fromEntries(Object.entries(m).filter(([,v])=>v.thresholds).map(([k,v])=>[k,v.thresholds])))];
  return {stdout: lines.join('\n')+'\n', [`quality/reports/${name}-report.json`]: JSON.stringify(data,null,2)};
}
