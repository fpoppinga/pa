function M = loadBinary(filename) 
    file = fopen(filename);
    M = fread(file, 'double');
    fclose(file);
end