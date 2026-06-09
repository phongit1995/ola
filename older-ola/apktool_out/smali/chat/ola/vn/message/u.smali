.class public abstract Lchat/ola/vn/message/u;
.super Lchat/ola/vn/message/f;


# instance fields
.field protected Z:Ljava/lang/String;

.field protected aa:Ljava/lang/String;

.field protected ab:Ljava/lang/String;

.field protected ac:Ljava/lang/String;

.field protected ad:I


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x5

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/message/u;->ad:I

    return-void
.end method


# virtual methods
.method public Y()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/u;->Z:Ljava/lang/String;

    return-object v0
.end method

.method public Z()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/u;->aa:Ljava/lang/String;

    return-object v0
.end method

.method public a(Landroid/content/Context;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public aa()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/u;->ab:Ljava/lang/String;

    return-object v0
.end method

.method public ab()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/message/u;->ac:Ljava/lang/String;

    return-object v0
.end method

.method public ac()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/message/u;->ad:I

    return v0
.end method
