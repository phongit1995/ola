.class public Lchat/ola/vn/w/dy;
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
    .locals 5

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x72

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    const/16 v0, 0x70

    const/16 v1, 0x6f

    const/16 v2, 0x6e

    const/16 v3, 0x6d

    const/16 v4, 0x4f

    packed-switch p3, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    invoke-virtual {p2, v4, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    if-eqz p3, :cond_0

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, v3, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    if-eqz p3, :cond_1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, v2, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    if-eqz p3, :cond_2

    iget-object p3, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    invoke-virtual {p2, v1, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    if-eqz p3, :cond_6

    goto :goto_0

    :pswitch_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    if-eqz p3, :cond_3

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, v3, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    if-eqz p3, :cond_4

    iget-object p3, p1, Lchat/ola/vn/w/bk;->A:Ljava/lang/String;

    invoke-virtual {p2, v2, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_4
    iget-object p3, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    if-eqz p3, :cond_5

    iget-object p3, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    invoke-virtual {p2, v1, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_5
    iget-object p3, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    if-eqz p3, :cond_6

    :goto_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    goto :goto_1

    :pswitch_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_6

    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    invoke-virtual {p2, v4, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_6
    :goto_1
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_7

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_7
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 10

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v9, v0

    const/16 v0, 0x4f

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x6d

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v1, 0x6e

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v1, 0x6f

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v1, 0x70

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/4 p1, 0x0

    if-eqz v0, :cond_1

    const-string v1, " "

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->e(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    array-length v1, v0

    const/4 v6, 0x1

    const/4 v7, 0x2

    if-ne v1, v7, :cond_0

    aget-object p3, v0, p3

    aget-object v0, v0, v6

    move-object v8, p1

    move-object v6, p3

    move-object v7, v0

    goto :goto_0

    :cond_0
    array-length v1, v0

    const/4 v8, 0x3

    if-ne v1, v8, :cond_1

    aget-object p1, v0, p3

    aget-object p3, v0, v6

    aget-object v0, v0, v7

    move-object v6, p1

    move-object v7, p3

    move-object v8, v0

    goto :goto_0

    :cond_1
    move-object v6, p1

    move-object v7, v6

    move-object v8, v7

    :goto_0
    move-object v1, p2

    invoke-interface/range {v1 .. v9}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method
