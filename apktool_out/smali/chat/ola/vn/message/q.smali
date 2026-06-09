.class public Lchat/ola/vn/message/q;
.super Lchat/ola/vn/message/d;


# instance fields
.field protected A:Ljava/lang/String;

.field protected B:Ljava/lang/String;

.field protected C:J

.field protected D:I

.field protected E:B

.field protected z:Lchat/ola/vn/entity/ah;


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/16 v0, 0x11

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/q;->A:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/message/q;->B:Ljava/lang/String;

    const-wide/16 p1, 0x0

    iput-wide p1, p0, Lchat/ola/vn/message/q;->C:J

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/message/q;->D:I

    const/4 p1, 0x1

    iput-byte p1, p0, Lchat/ola/vn/message/q;->E:B

    const-string p1, "received-tradding-vip"

    invoke-virtual {p0, p1}, Lchat/ola/vn/message/q;->h(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public C()J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/message/q;->C:J

    return-wide v0
.end method

.method public D()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/message/q;->D:I

    return v0
.end method

.method public E()B
    .locals 1

    iget-byte v0, p0, Lchat/ola/vn/message/q;->E:B

    return v0
.end method

.method public F()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/q;->A:Ljava/lang/String;

    return-object v0
.end method

.method public G()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/q;->B:Ljava/lang/String;

    return-object v0
.end method

.method public a()Lchat/ola/vn/entity/ah;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/q;->z:Lchat/ola/vn/entity/ah;

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/ah;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/q;->z:Lchat/ola/vn/entity/ah;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/q;->A:Ljava/lang/String;

    return-void
.end method

.method public b(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/message/q;->D:I

    return-void
.end method

.method public b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public c(B)V
    .locals 2

    iput-byte p1, p0, Lchat/ola/vn/message/q;->E:B

    iget-object p1, p0, Lchat/ola/vn/message/q;->a:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/q;->a:Lchat/ola/vn/message/f;

    iget-byte v0, p0, Lchat/ola/vn/message/q;->u:B

    iget-byte v1, p0, Lchat/ola/vn/message/q;->u:B

    invoke-virtual {p1, p0, v0, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;BB)V

    :cond_0
    return-void
.end method

.method public c(J)V
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/message/q;->C:J

    return-void
.end method

.method public n(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/q;->B:Ljava/lang/String;

    return-void
.end method
