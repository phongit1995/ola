.class Lchat/ola/vn/me/OlaUserMePageActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaUserMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$8;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public b_(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$8;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity$8;->a:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
