.class final Lchat/ola/vn/activity/OlaCropImageActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaCropImageActivity$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;ILchat/ola/vn/activity/OlaCropImageActivity$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field a:Landroid/app/ProgressDialog;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/activity/OlaCropImageActivity$a;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 2

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->b:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->c:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->d:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->b:Landroid/content/Context;

    const p3, 0x7f0f0681

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->b:Landroid/content/Context;

    const v0, 0x7f0f038b

    invoke-virtual {p3, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x0

    const/16 v1, 0x64

    invoke-static {p1, v0, v1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;IILjava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->a:Landroid/app/ProgressDialog;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V

    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v0

    const-string v1, "jpg"

    new-instance v2, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$2;Ljava/lang/String;)V

    const/4 v3, 0x0

    invoke-virtual {v0, p1, v1, v3, v2}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    return-void
.end method
