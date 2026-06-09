.class Lchat/ola/vn/w/cz;
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

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    if-eqz p3, :cond_3

    const/16 p3, 0xe

    iget-object p1, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 1

    const/16 v0, 0xb

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->a(S)[B

    move-result-object p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/w/ci;->a([B)V

    invoke-interface {p2}, Lchat/ola/vn/p/g;->f()V

    return-void
.end method
