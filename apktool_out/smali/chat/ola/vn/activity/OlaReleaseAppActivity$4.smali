.class Lchat/ola/vn/activity/OlaReleaseAppActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaReleaseAppActivity;->I()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaReleaseAppActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaReleaseAppActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$4;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    const-string v1, ""

    iput-object v1, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ai;)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object p1, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    const-string v0, ""

    iput-object v0, p1, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    :goto_0
    sget-object p1, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object p1, p1, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaReleaseAppActivity$4;->a:Lchat/ola/vn/activity/OlaReleaseAppActivity;

    sget-object v0, Lchat/ola/vn/activity/OlaReleaseAppActivity;->e:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->b(Lchat/ola/vn/activity/OlaReleaseAppActivity;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method
