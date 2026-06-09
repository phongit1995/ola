.class Lchat/ola/vn/tutorial/a$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/tutorial/a;->v()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/tutorial/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/tutorial/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x26

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 1

    const p2, 0x7f0f0280

    const/4 p4, 0x0

    const/16 v0, 0xa

    if-eq p1, v0, :cond_1

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {p1, p4}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/a;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object p1

    iget-object p4, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {p4, p2}, Lchat/ola/vn/tutorial/a;->getString(I)Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {p1, p4}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/a;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {p3, p2}, Lchat/ola/vn/tutorial/a;->getString(I)Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    const p4, 0x7f0f0263

    invoke-virtual {p3, p4}, Lchat/ola/vn/tutorial/a;->getString(I)Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {p1, p4}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/a;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object p1

    const p3, 0x7f0f0253

    invoke-static {p1, p2, p3}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {p1}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {p1}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 2

    const/4 p1, 0x0

    :try_start_0
    sput-boolean p1, Lchat/ola/vn/tutorial/OlaTutorialActivity;->e:Z

    iget-object v0, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {v0}, Lchat/ola/vn/tutorial/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {v1}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;)Landroid/widget/EditText;

    move-result-object v1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-static {v0, p1}, Lchat/ola/vn/tutorial/a;->a(Lchat/ola/vn/tutorial/a;Z)V

    iget-object p1, p0, Lchat/ola/vn/tutorial/a$1;->a:Lchat/ola/vn/tutorial/a;

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/a;->j()Lchat/ola/vn/tutorial/OlaTutorialActivity;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/tutorial/OlaTutorialActivity;->B()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_0
    return-void
.end method
