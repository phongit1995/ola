.class public Lchat/ola/vn/e/g;
.super Lchat/ola/vn/e/f;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/e/f;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/f;)I
    .locals 10

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->g()S

    move-result v1

    const/4 v2, -0x1

    if-le v0, v1, :cond_0

    return v2

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->g()S

    move-result v1

    const/4 v3, 0x1

    if-ge v0, v1, :cond_1

    return v3

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    const-wide/16 v4, 0x0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_4

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    if-ne v0, v1, :cond_4

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->v()J

    move-result-wide v6

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->v()J

    move-result-wide v8

    cmp-long v0, v6, v4

    if-gtz v0, :cond_2

    cmp-long v0, v8, v4

    if-lez v0, :cond_4

    :cond_2
    cmp-long v0, v6, v8

    if-lez v0, :cond_3

    return v2

    :cond_3
    cmp-long v0, v6, v8

    if-gez v0, :cond_4

    return v3

    :cond_4
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    if-eq v0, v1, :cond_9

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    if-eq v0, v1, :cond_9

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->v()J

    move-result-wide v0

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->v()J

    move-result-wide v6

    cmp-long v8, v0, v4

    if-gtz v8, :cond_5

    cmp-long v8, v6, v4

    if-lez v8, :cond_7

    :cond_5
    cmp-long v4, v0, v6

    if-lez v4, :cond_6

    return v2

    :cond_6
    cmp-long v4, v0, v6

    if-gez v4, :cond_7

    return v3

    :cond_7
    iget-wide v0, p1, Lchat/ola/vn/message/f;->N:J

    iget-wide v4, p2, Lchat/ola/vn/message/f;->N:J

    cmp-long v6, v0, v4

    if-gez v6, :cond_8

    return v3

    :cond_8
    iget-wide v0, p1, Lchat/ola/vn/message/f;->N:J

    iget-wide v3, p2, Lchat/ola/vn/message/f;->N:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v5, v0, v3

    if-lez v5, :cond_9

    return v2

    :catch_0
    :cond_9
    invoke-super {p0, p1, p2}, Lchat/ola/vn/e/f;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/f;)I

    move-result p1

    return p1
.end method

.method public synthetic compare(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lchat/ola/vn/message/f;

    check-cast p2, Lchat/ola/vn/message/f;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/e/g;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/f;)I

    move-result p1

    return p1
.end method
