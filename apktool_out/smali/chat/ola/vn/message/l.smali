.class public Lchat/ola/vn/message/l;
.super Lchat/ola/vn/message/d;


# instance fields
.field private A:Ljava/lang/String;

.field private B:Ljava/lang/String;

.field protected z:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/message/d;-><init>()V

    return-void
.end method

.method public constructor <init>(Lchat/ola/vn/message/d;B)V
    .locals 1

    const/16 v0, 0x8

    invoke-direct {p0, p1, p2, v0}, Lchat/ola/vn/message/d;-><init>(Lchat/ola/vn/message/d;BB)V

    return-void
.end method


# virtual methods
.method public C()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/l;->A:Ljava/lang/String;

    return-object v0
.end method

.method public D()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/l;->B:Ljava/lang/String;

    return-object v0
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/l;->z:Ljava/lang/String;

    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/l;->z:Ljava/lang/String;

    return-void
.end method

.method protected h()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public n(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/l;->A:Ljava/lang/String;

    return-void
.end method

.method public o(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/l;->B:Ljava/lang/String;

    return-void
.end method

.method public w()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
