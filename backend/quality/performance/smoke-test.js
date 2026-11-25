import {prepare, scenario, summary} from './common.js';
export const options = {vus: 1, duration: '10s', thresholds:{http_req_duration:['p(95)<500'],http_req_failed:['rate==0'],checks:['rate==1']}, summaryTrendStats:['avg','min','med','max','p(95)','p(99)']};
export function setup() { prepare(); }
export default function () { scenario(); }
export function handleSummary(data) { return summary(data, 'smoke'); }
