.class public Lchat/ola/vn/entry/b/i;
.super Ljava/lang/Object;


# direct methods
.method public static a(ILandroid/view/View;Landroid/view/LayoutInflater;)Lchat/ola/vn/entry/b/j;
    .locals 3

    const v0, 0x7f0b00ef

    const/4 v1, 0x0

    const/4 v2, 0x0

    packed-switch p0, :pswitch_data_0

    :pswitch_0
    goto :goto_1

    :pswitch_1
    const p0, 0x7f0b015c

    :try_start_0
    invoke-virtual {p2, p0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/ac;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ac;-><init>()V

    goto :goto_0

    :pswitch_2
    const p0, 0x7f0b00f0

    invoke-virtual {p2, p0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/aa;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/aa;-><init>()V

    goto :goto_0

    :pswitch_3
    const p0, 0x7f0b00ee

    invoke-virtual {p2, p0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/z;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/z;-><init>()V

    goto :goto_0

    :pswitch_4
    const p0, 0x7f0b00eb

    invoke-virtual {p2, p0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/x;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/x;-><init>()V

    goto :goto_0

    :pswitch_5
    const p0, 0x7f0b00ea

    invoke-virtual {p2, p0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/w;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;-><init>()V

    goto :goto_0

    :pswitch_6
    const p0, 0x7f0b00f4

    invoke-virtual {p2, p0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/y;

    invoke-direct {p0, p1, v1}, Lchat/ola/vn/entry/b/y;-><init>(Landroid/view/View;I)V

    goto :goto_0

    :pswitch_7
    invoke-virtual {p2, v0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/ab;

    const p2, 0x7f0b00e5

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entry/b/ab;-><init>(Landroid/view/View;I)V

    goto :goto_0

    :pswitch_8
    invoke-virtual {p2, v0, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    new-instance p0, Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0, p1, v1}, Lchat/ola/vn/entry/b/ab;-><init>(Landroid/view/View;I)V

    :goto_0
    move-object v2, p0

    :goto_1
    :pswitch_9
    invoke-virtual {v2, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-object v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_8
        :pswitch_7
        :pswitch_0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_9
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
