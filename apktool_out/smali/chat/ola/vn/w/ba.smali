.class Lchat/ola/vn/w/ba;
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
    .locals 2

    iget-object p3, p1, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    const/16 p3, 0xc

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->g:Ljava/lang/String;

    const/16 v0, 0x3d

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    if-eqz p3, :cond_0

    const/16 p3, 0x5e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    if-eqz p3, :cond_1

    const/16 p3, 0x32

    iget-object v0, p1, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    if-eqz p3, :cond_2

    const/16 p3, 0x56

    iget-object v0, p1, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    const/16 p3, 0x33

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p1, Lchat/ola/vn/w/bk;->X:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p1, Lchat/ola/vn/w/bk;->Y:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->M:Ljava/lang/String;

    if-eqz p3, :cond_3

    const/16 p3, 0x6e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->M:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    iget-object p3, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    if-eqz p3, :cond_4

    const/16 p3, 0x6f

    iget-object v0, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_4
    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    if-eqz p3, :cond_5

    const/16 p3, 0x4f

    iget-object v0, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_5
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_6

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_6
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 9

    const/4 v0, 0x0

    const/16 v1, 0xff

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v1

    int-to-short v1, v1

    const/4 v2, 0x4

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x16

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0xd

    invoke-virtual {p1, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x6e

    invoke-virtual {p1, v5}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x3d

    invoke-virtual {p1, v6}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_0

    const-string v6, "US"

    :cond_0
    sput-object v6, Lchat/ola/vn/h;->T:Ljava/lang/String;

    const/16 v6, 0x9

    invoke-virtual {p1, v6, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    const-wide/16 v7, 0x0

    invoke-virtual {p1, v6, v7, v8}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v6

    const/16 v8, 0x2d

    invoke-virtual {p1, v8, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    const/4 v8, -0x1

    invoke-virtual {p1, v0, v8}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    iput-object v2, p3, Lchat/ola/vn/w/ci;->j:Ljava/lang/String;

    iput-object v3, p3, Lchat/ola/vn/w/ci;->h:Ljava/lang/String;

    if-ltz p1, :cond_1

    iput-short p1, p3, Lchat/ola/vn/w/ci;->o:S

    :cond_1
    iput-object v4, p3, Lchat/ola/vn/w/ci;->i:Ljava/lang/String;

    iput-wide v6, p3, Lchat/ola/vn/w/ci;->e:J

    iput-object v5, p3, Lchat/ola/vn/w/ci;->k:Ljava/lang/String;

    const/4 p1, 0x1

    invoke-virtual {p3, p1}, Lchat/ola/vn/w/ci;->c(Z)V

    invoke-interface {p2, p3, v1}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/w/ci;S)V

    invoke-virtual {p3}, Lchat/ola/vn/w/ci;->b()V

    return-void
.end method
