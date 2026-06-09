.class Lchat/ola/vn/entry/b/a/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/a/c;-><init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/a/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/a/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/c$1;->a:Lchat/ola/vn/entry/b/a/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$1;->a:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
