.class Lchat/ola/vn/me/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/c;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/c$1;->a:Lchat/ola/vn/me/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0

    if-eqz p2, :cond_0

    goto :goto_0

    :cond_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    invoke-interface {p2}, Lchat/ola/vn/r/a;->c()V

    iget-object p2, p0, Lchat/ola/vn/me/c$1;->a:Lchat/ola/vn/me/c;

    invoke-static {p2}, Lchat/ola/vn/me/c;->a(Lchat/ola/vn/me/c;)Lchat/ola/vn/me/b;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/me/b;->notifyDataSetChanged()V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
