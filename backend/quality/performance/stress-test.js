import {prepare, scenario, summary} from './common.js';
export const options = {stages:[{duration:'30s',target:20},{duration:'30s',target:50},{duration:'30s',target:100},{duration:'30s',target:100},{duration:'30s',target:0}], thresholds:{http_req_duration:['p(95)<1000'],http_req_failed:['rate<0.05'],checks:['rate>0.95']}, summaryTrendStats:['avg','min','med','max','p(95)','p(99)']};
export function setup() { prepare(); }
export default function () { scenario(); }
export function handleSummary(data) { return summary(data, 'stress'); }
