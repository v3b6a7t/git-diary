import { expect } from 'chai';
import 'mocha';

describe('TypeScript', () => {
    it('generic function tested', () => {
        const genericTest = <T>(t: T): T => t;
        const stringValue: string = 'Ala ma kota';
        const numberValue: number = 100;
        const symbolValue: symbol = Symbol();

        expect(
            genericTest<string>(stringValue) === stringValue
            && genericTest<number>(numberValue) === numberValue
            && genericTest<symbol>(symbolValue) === symbolValue
        ).to.equal(true);
    })
})