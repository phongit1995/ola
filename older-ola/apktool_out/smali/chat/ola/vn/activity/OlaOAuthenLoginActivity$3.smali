.class Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Void;",
        "Ljava/lang/Void;",
        "Landroid/content/Intent;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->c:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->b:Ljava/lang/String;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method


# virtual methods
.method protected varargs a([Ljava/lang/Void;)Landroid/content/Intent;
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->a:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object p1

    return-object p1
.end method

.method protected a(Landroid/content/Intent;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->c:Lchat/ola/vn/activity/OlaOAuthenLoginActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity;->a(Lchat/ola/vn/activity/OlaOAuthenLoginActivity;Landroid/content/Intent;)V

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->a([Ljava/lang/Void;)Landroid/content/Intent;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Landroid/content/Intent;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaOAuthenLoginActivity$3;->a(Landroid/content/Intent;)V

    return-void
.end method
