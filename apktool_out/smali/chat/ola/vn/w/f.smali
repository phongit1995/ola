.class public Lchat/ola/vn/w/f;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# instance fields
.field e:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->z:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/w/f;->e:Ljava/lang/String;

    iget-object p3, p1, Lchat/ola/vn/w/bk;->e:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->am:[B

    const/16 v0, 0x2b

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(S[B)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_0

    const/4 p3, 0x5

    iget-object v0, p1, Lchat/ola/vn/w/bk;->k:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_0
    const/16 p3, 0x3d

    iget-object v0, p1, Lchat/ola/vn/w/bk;->g:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-object p3, p1, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    if-eqz p3, :cond_1

    const/16 p3, 0x5e

    iget-object v0, p1, Lchat/ola/vn/w/bk;->x:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_1
    iget-object p3, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    if-eqz p3, :cond_2

    const/16 p3, 0x6f

    iget-object v0, p1, Lchat/ola/vn/w/bk;->B:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_2
    iget-object p3, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    if-eqz p3, :cond_3

    const/16 p3, 0x70

    iget-object v0, p1, Lchat/ola/vn/w/bk;->C:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_3
    iget-object p3, p1, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    if-eqz p3, :cond_4

    const/16 p3, 0x32

    iget-object v0, p1, Lchat/ola/vn/w/bk;->h:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_4
    iget-object p3, p1, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    if-eqz p3, :cond_5

    const/16 p3, 0x56

    iget-object v0, p1, Lchat/ola/vn/w/bk;->y:Ljava/lang/String;

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    :cond_5
    iget-object p3, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

    if-eqz p3, :cond_6

    const/16 p3, 0x4f

    iget-object v0, p1, Lchat/ola/vn/w/bk;->c:Ljava/lang/String;

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
    .locals 9

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v8, v0

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    const/16 v0, 0x87

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v0, 0x70

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v0, 0x9

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result p3

    const-wide/16 v0, 0x0

    invoke-virtual {p1, p3, v0, v1}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v6

    iget-object v3, p0, Lchat/ola/vn/w/f;->e:Ljava/lang/String;

    move-object v1, p2

    invoke-interface/range {v1 .. v8}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JS)V

    return-void
.end method
