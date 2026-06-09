.class public Lchat/ola/vn/m/d;
.super Lchat/ola/vn/m/a;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/f/a;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation


# static fields
.field private static d:Lchat/ola/vn/m/d;


# instance fields
.field private a:Landroid/widget/ListView;

.field private b:Lchat/ola/vn/b/i;

.field private c:Landroid/view/View;

.field private e:Lchat/ola/vn/i/c;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/a;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/d;)Lchat/ola/vn/i/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/d;->e:Lchat/ola/vn/i/c;

    return-object p0
.end method

.method private a(Lchat/ola/vn/entry/e;)V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entry/e;->a(Landroid/content/Context;)Z

    return-void
.end method

.method public static c()Lchat/ola/vn/m/d;
    .locals 1

    sget-object v0, Lchat/ola/vn/m/d;->d:Lchat/ola/vn/m/d;

    return-object v0
.end method


# virtual methods
.method protected a(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->a(Landroid/os/Bundle;)V

    return-void
.end method

.method public b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->b(Landroid/os/Bundle;)V

    sput-object p0, Lchat/ola/vn/m/d;->d:Lchat/ola/vn/m/d;

    new-instance p1, Lchat/ola/vn/b/i;

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/i;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/d;->b:Lchat/ola/vn/b/i;

    iget-object p1, p0, Lchat/ola/vn/m/d;->a:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/m/d;->b:Lchat/ola/vn/b/i;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public d()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/m/d;->b:Lchat/ola/vn/b/i;

    invoke-virtual {v0}, Lchat/ola/vn/b/i;->notifyDataSetChanged()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 0

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b0022

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/d;->c:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/d;->c:Landroid/view/View;

    const p2, 0x7f09006b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ListView;

    iput-object p1, p0, Lchat/ola/vn/m/d;->a:Landroid/widget/ListView;

    iget-object p1, p0, Lchat/ola/vn/m/d;->c:Landroid/view/View;

    const p2, 0x7f09039c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/d;->c:Landroid/view/View;

    const p2, 0x7f0903a3

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const p2, 0x7f0f00dc

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/m/d;->a:Landroid/widget/ListView;

    invoke-virtual {p1, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/m/d;->c:Landroid/view/View;

    return-object p1
.end method

.method public onDetach()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/m/d;->d:Lchat/ola/vn/m/d;

    invoke-super {p0}, Lchat/ola/vn/m/a;->onDetach()V

    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/d;->b:Lchat/ola/vn/b/i;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/i;->a(I)Lchat/ola/vn/entry/e;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->d()I

    move-result p3

    const/4 p4, 0x1

    const/4 p5, 0x0

    const/4 v0, 0x0

    sparse-switch p3, :sswitch_data_0

    invoke-direct {p0, p1}, Lchat/ola/vn/m/d;->a(Lchat/ola/vn/entry/e;)V

    goto/16 :goto_0

    :sswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    :sswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, p5}, Lchat/ola/vn/m/z;->a(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const/4 p2, 0x2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    goto/16 :goto_0

    :sswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Landroid/content/Context;)V

    const-string p2, ""

    invoke-virtual {p1, p2}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    invoke-virtual {p1, p4}, Lchat/ola/vn/entry/e;->b(I)V

    goto/16 :goto_0

    :sswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, p5}, Lchat/ola/vn/util/b;->b(Landroid/content/Context;Ljava/lang/String;)V

    goto/16 :goto_0

    :sswitch_5
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/m/k;->a(Landroid/content/Context;)V

    if-eqz p2, :cond_2

    invoke-virtual {p2, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(I)V

    goto/16 :goto_0

    :sswitch_6
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-string p2, "note"

    const p3, 0x7f0f00f0

    invoke-virtual {p0, p3}, Lchat/ola/vn/m/d;->getString(I)Ljava/lang/String;

    move-result-object p3

    invoke-static {p1, p2, p3}, Lchat/ola/vn/m/m;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    :sswitch_7
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, v0}, Lchat/ola/vn/n/b;->a(Landroid/app/Activity;I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/d;->e:Lchat/ola/vn/i/c;

    if-nez p1, :cond_1

    new-instance p1, Lchat/ola/vn/i/c;

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-direct {p1, p2}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/d;->e:Lchat/ola/vn/i/c;

    iget-object p1, p0, Lchat/ola/vn/m/d;->e:Lchat/ola/vn/i/c;

    const p2, 0x7f0f0275

    invoke-virtual {p1, p2}, Lchat/ola/vn/i/c;->a(I)V

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const-wide/16 p2, 0x2710

    new-instance p4, Lchat/ola/vn/m/d$1;

    invoke-direct {p4, p0}, Lchat/ola/vn/m/d$1;-><init>(Lchat/ola/vn/m/d;)V

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :sswitch_8
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Landroid/content/Context;)V

    goto :goto_0

    :sswitch_9
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, p4}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    goto :goto_0

    :sswitch_a
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->a()Lchat/ola/vn/activity/OlaBottomTabActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->J()V

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    const/16 p2, 0xa

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    goto :goto_0

    :sswitch_b
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    goto :goto_0

    :sswitch_c
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    :catch_0
    :cond_2
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/m/d;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0f00e1 -> :sswitch_c
        0x7f0f00e2 -> :sswitch_b
        0x7f0f00ea -> :sswitch_a
        0x7f0f00eb -> :sswitch_9
        0x7f0f00ee -> :sswitch_8
        0x7f0f00ef -> :sswitch_7
        0x7f0f00f0 -> :sswitch_6
        0x7f0f00f1 -> :sswitch_5
        0x7f0f00f2 -> :sswitch_4
        0x7f0f00f5 -> :sswitch_3
        0x7f0f00f8 -> :sswitch_2
        0x7f0f00fa -> :sswitch_1
        0x7f0f00fb -> :sswitch_0
    .end sparse-switch
.end method

.method public onResume()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/m/a;->onResume()V

    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->h()V

    iget-object v0, p0, Lchat/ola/vn/m/d;->b:Lchat/ola/vn/b/i;

    invoke-virtual {v0}, Lchat/ola/vn/b/i;->notifyDataSetChanged()V

    invoke-virtual {p0}, Lchat/ola/vn/m/d;->d()V

    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/m/a;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method
