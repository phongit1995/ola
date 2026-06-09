.class public Lchat/ola/vn/message/i;
.super Lchat/ola/vn/message/d;


# instance fields
.field private z:Lchat/ola/vn/entity/z;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/message/d;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/message/i;->z:Lchat/ola/vn/entity/z;

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/16 v0, 0xa

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/message/i;->z:Lchat/ola/vn/entity/z;

    return-void
.end method


# virtual methods
.method public a()Lchat/ola/vn/entity/z;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/i;->z:Lchat/ola/vn/entity/z;

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/z;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/i;->z:Lchat/ola/vn/entity/z;

    return-void
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public w()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
