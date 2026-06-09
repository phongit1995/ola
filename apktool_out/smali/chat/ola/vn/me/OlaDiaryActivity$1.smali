.class Lchat/ola/vn/me/OlaDiaryActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaDiaryActivity;->C()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaDiaryActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaDiaryActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$1;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onRefresh()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$1;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Lchat/ola/vn/me/OlaDiaryActivity;Z)Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$1;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaDiaryActivity;->b(Lchat/ola/vn/me/OlaDiaryActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$1;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Lchat/ola/vn/me/OlaDiaryActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$1;->a:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-static {v0}, Lchat/ola/vn/me/OlaDiaryActivity;->a(Lchat/ola/vn/me/OlaDiaryActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
