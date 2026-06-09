.class public Lchat/ola/vn/message/t;
.super Lchat/ola/vn/message/d;


# instance fields
.field public A:S

.field private B:Ljava/lang/String;

.field public z:S


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/16 v0, 0x9

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const/4 p1, 0x0

    iput-short p1, p0, Lchat/ola/vn/message/t;->z:S

    iput-short p1, p0, Lchat/ola/vn/message/t;->A:S

    return-void
.end method


# virtual methods
.method public C()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/t;->A:S

    return v0
.end method

.method public D()S
    .locals 1

    iget-short v0, p0, Lchat/ola/vn/message/t;->z:S

    return v0
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/t;->B:Ljava/lang/String;

    return-object v0
.end method

.method public a(Ljava/lang/String;S)V
    .locals 0

    iput-short p2, p0, Lchat/ola/vn/message/t;->z:S

    iget-short p2, p0, Lchat/ola/vn/message/t;->z:S

    iput-short p2, p0, Lchat/ola/vn/message/t;->A:S

    iput-object p1, p0, Lchat/ola/vn/message/t;->B:Ljava/lang/String;

    return-void
.end method

.method public b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public d(S)V
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/message/t;->A:S

    return-void
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
