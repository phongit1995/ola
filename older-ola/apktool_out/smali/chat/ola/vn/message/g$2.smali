.class Lchat/ola/vn/message/g$2;
.super Lchat/ola/vn/message/f;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/message/g;->h()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/g;


# direct methods
.method constructor <init>(Lchat/ola/vn/message/g;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/g$2;->a:Lchat/ola/vn/message/g;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    return-void
.end method


# virtual methods
.method public w()Ljava/lang/String;
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/message/f;->w()Ljava/lang/String;

    move-result-object v0

    :try_start_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const v1, 0x7f0f0470

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    :catch_0
    :cond_0
    return-object v0
.end method
