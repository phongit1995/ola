.class public Lchat/ola/vn/w/cg;
.super Ljava/lang/Object;


# instance fields
.field public a:Z

.field private b:Ljava/io/DataOutputStream;

.field private c:S

.field private d:Ljava/io/ByteArrayOutputStream;


# direct methods
.method public constructor <init>(S)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/w/cg;->a:Z

    iput-short p1, p0, Lchat/ola/vn/w/cg;->c:S

    iput-boolean v0, p0, Lchat/ola/vn/w/cg;->a:Z

    new-instance p1, Ljava/io/ByteArrayOutputStream;

    const/16 v0, 0x2814

    invoke-direct {p1, v0}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/w/cg;->d:Ljava/io/ByteArrayOutputStream;

    new-instance p1, Ljava/io/DataOutputStream;

    iget-object v0, p0, Lchat/ola/vn/w/cg;->d:Ljava/io/ByteArrayOutputStream;

    invoke-direct {p1, v0}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    iput-object p1, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    if-eqz v0, :cond_0

    array-length v1, v0

    if-nez v1, :cond_1

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    array-length v2, v0

    invoke-virtual {v1, v2}, Ljava/io/DataOutputStream;->writeInt(I)V

    iget-object v1, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v1, v0}, Ljava/io/DataOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    array-length v1, p1

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->writeInt(I)V

    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v0, p1}, Ljava/io/DataOutputStream;->write([B)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method private a([B)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    array-length v1, p1

    invoke-virtual {v0, v1}, Ljava/io/DataOutputStream;->writeInt(I)V

    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v0, p1}, Ljava/io/DataOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(SB)V
    .locals 2

    const/4 v0, 0x1

    new-array v0, v0, [B

    const/4 v1, 0x0

    aput-byte p2, v0, v1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(SI)V
    .locals 0

    invoke-static {p2}, Lchat/ola/vn/util/e;->a(I)[B

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(SJ)V
    .locals 0

    invoke-static {p2, p3}, Lchat/ola/vn/util/e;->a(J)[B

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 1

    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v0, p1}, Ljava/io/DataOutputStream;->write(I)V

    invoke-direct {p0, p2}, Lchat/ola/vn/w/cg;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(SS)V
    .locals 0

    invoke-static {p2}, Lchat/ola/vn/util/e;->a(S)[B

    move-result-object p2

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/w/cg;->a(S[B)V

    return-void
.end method

.method public a(S[B)V
    .locals 1

    if-eqz p2, :cond_0

    :try_start_0
    array-length v0, p2

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v0, p1}, Ljava/io/DataOutputStream;->write(I)V

    invoke-direct {p0, p2}, Lchat/ola/vn/w/cg;->a([B)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a()[B
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->flush()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_0
    :goto_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/w/cg;->d:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/w/cg;->d:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V

    iget-object v1, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-object v0

    :goto_1
    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/w/cg;->d:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V

    iget-object v1, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v1}, Ljava/io/DataOutputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    throw v0

    :catch_3
    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/w/cg;->d:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V

    iget-object v0, p0, Lchat/ola/vn/w/cg;->b:Ljava/io/DataOutputStream;

    invoke-virtual {v0}, Ljava/io/DataOutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    const/4 v0, 0x0

    return-object v0
.end method

.method public b()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/w/cg;->c:S

    return v0
.end method
