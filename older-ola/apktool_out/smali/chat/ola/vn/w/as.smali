.class public Lchat/ola/vn/w/as;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_0

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_1

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_2

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_3

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 7

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v6, v0

    const/16 v0, 0x1d

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, ";"

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v2

    :catch_0
    :cond_0
    move-object v5, v1

    const/16 v1, 0x6d

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x6e

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v2, 0x72

    invoke-virtual {p1, v2, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {p1, v2, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v2, v2

    packed-switch v2, :pswitch_data_0

    :pswitch_0
    return-void

    :pswitch_1
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-interface {p2, v0, v6}, Lchat/ola/vn/p/g;->f(Ljava/lang/String;S)V

    return-void

    :pswitch_2
    invoke-interface {p2, v1, v4, v5, v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_3
    const/16 v0, 0x73

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    invoke-interface {p2, p1, v6}, Lchat/ola/vn/p/g;->b(SS)V

    return-void

    :pswitch_4
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-interface {p2, v1, v6}, Lchat/ola/vn/p/g;->e(Ljava/lang/String;S)V

    return-void

    :pswitch_5
    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-interface {p2, v1, v6}, Lchat/ola/vn/p/g;->d(Ljava/lang/String;S)V

    return-void

    :pswitch_6
    invoke-interface {p2, v4, v5, v6}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_7
    invoke-interface {p2, v4, v5, v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_8
    invoke-interface {p2, v1, v4, v5, v6}, Lchat/ola/vn/p/g;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_9
    invoke-interface {p2, v1, v4, v5, v6}, Lchat/ola/vn/p/g;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_a
    invoke-interface {p2, v1, v4, v5, v6}, Lchat/ola/vn/p/g;->c(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_b
    invoke-interface {p2, v1, v4, v5, v6}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    return-void

    :pswitch_c
    :try_start_1
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    move-object v1, p2

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/p/g;->a(JLjava/lang/String;[Ljava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_0
        :pswitch_5
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
