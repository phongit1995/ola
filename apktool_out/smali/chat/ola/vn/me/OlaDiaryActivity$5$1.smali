.class Lchat/ola/vn/me/OlaDiaryActivity$5$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaDiaryActivity$5;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaDiaryActivity$5;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaDiaryActivity$5;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_3

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(J)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->m()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->r(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->c:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->m()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->s(Ljava/lang/String;)V

    :cond_2
    :goto_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object p2, p2, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaDiaryActivity;->b(Lchat/ola/vn/me/OlaDiaryActivity;)Lchat/ola/vn/r/a/e;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object v0, v0, Lchat/ola/vn/me/OlaDiaryActivity$5;->d:Lchat/ola/vn/entry/b;

    invoke-virtual {p2, v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/entry/b;)Z

    iget-object p2, p0, Lchat/ola/vn/me/OlaDiaryActivity$5$1;->a:Lchat/ola/vn/me/OlaDiaryActivity$5;

    iget-object p2, p2, Lchat/ola/vn/me/OlaDiaryActivity$5;->f:Lchat/ola/vn/me/OlaDiaryActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaDiaryActivity;->c(Lchat/ola/vn/me/OlaDiaryActivity;)Lchat/ola/vn/b/u;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    :cond_3
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
