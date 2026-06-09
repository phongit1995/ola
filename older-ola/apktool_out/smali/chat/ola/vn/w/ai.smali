.class Lchat/ola/vn/w/ai;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->p:Ljava/lang/String;

    const/4 v0, 0x7

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 11

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v0, v0

    const/4 v1, 0x7

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    const/16 v3, 0x6d

    if-eqz v2, :cond_0

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p1, v0}, Lchat/ola/vn/p/g;->b(Ljava/lang/String;S)V

    return-void

    :cond_0
    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x6e

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x6f

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x42

    invoke-virtual {p1, v5, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v5

    invoke-virtual {p1, v5, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v5

    int-to-short v5, v5

    const/16 v6, 0x7c

    invoke-virtual {p1, v6, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    invoke-virtual {p1, v6, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result v6

    const/16 v7, 0x7d

    invoke-virtual {p1, v7, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v7

    invoke-virtual {p1, v7, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result v7

    const/16 v8, 0x7e

    invoke-virtual {p1, v8, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v8

    invoke-virtual {p1, v8, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result v8

    const/16 v9, 0x82

    invoke-virtual {p1, v9, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result p3

    const-wide/16 v9, 0x0

    invoke-virtual {p1, p3, v9, v10}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v9

    new-instance p1, Lchat/ola/vn/entity/b;

    invoke-direct {p1}, Lchat/ola/vn/entity/b;-><init>()V

    iput-object v1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    iput-object v2, p1, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    iput-object v3, p1, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;

    iput-object v4, p1, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    iput-short v5, p1, Lchat/ola/vn/entity/b;->j:S

    iput v6, p1, Lchat/ola/vn/entity/b;->f:I

    iput v7, p1, Lchat/ola/vn/entity/b;->g:I

    iput v8, p1, Lchat/ola/vn/entity/b;->h:I

    iput-wide v9, p1, Lchat/ola/vn/entity/b;->i:J

    invoke-interface {p2, p1, v0}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/entity/b;S)V

    return-void
.end method
