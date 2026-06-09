.class Lchat/ola/vn/me/OlaClanMePageActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaClanMePageActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaClanMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->a(Lchat/ola/vn/me/OlaClanMePageActivity;)Ljava/lang/Runnable;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$1$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$1$1;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity$1;)V

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaClanMePageActivity;->a(Lchat/ola/vn/me/OlaClanMePageActivity;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->d(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->e(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->a(Lchat/ola/vn/me/OlaClanMePageActivity;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity$1;->a:Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->a(Lchat/ola/vn/me/OlaClanMePageActivity;)Ljava/lang/Runnable;

    move-result-object v0

    const-wide/16 v1, 0x7530

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
