.class Lchat/ola/vn/w/dv;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# instance fields
.field private e:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/w/dv;->e:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 2

    iget-object p3, p1, Lchat/ola/vn/w/bk;->f:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/dv;->e:Ljava/lang/String;

    iget-object p3, p1, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    invoke-virtual {p3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x2

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->am:[B

    const/16 v0, 0x2b

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(S[B)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/16 p3, 0x16

    iget-object v0, p1, Lchat/ola/vn/w/bk;->i:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    iget-object p3, p1, Lchat/ola/vn/w/bk;->j:Ljava/lang/String;

    if-eqz p3, :cond_1

    const/4 p3, 0x4

    iget-object v0, p1, Lchat/ola/vn/w/bk;->j:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    if-eqz p3, :cond_2

    const/16 p3, 0x3a

    iget-object v0, p1, Lchat/ola/vn/w/bk;->O:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    if-eqz p3, :cond_3

    const/4 p3, 0x5

    iget-object v0, p1, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    iget-byte p3, p1, Lchat/ola/vn/w/bk;->ar:B

    if-ltz p3, :cond_4

    const/16 p3, 0x58

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->ar:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_4
    iget-object p3, p1, Lchat/ola/vn/w/bk;->d:Ljava/lang/String;

    if-eqz p3, :cond_5

    const/16 p3, 0x8e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->d:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_5
    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    if-eqz p3, :cond_6

    const/16 p3, 0x6d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_6
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_7

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_7
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 2

    const/4 v0, 0x0

    const/16 v1, 0xff

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/w/s;->a(IS)B

    move-result p1

    int-to-short p1, p1

    iget-object p3, p3, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/w/dv;->e:Ljava/lang/String;

    invoke-interface {p2, p3, v0, p1}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;S)V

    return-void
.end method
