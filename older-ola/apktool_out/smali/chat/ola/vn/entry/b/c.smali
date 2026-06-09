.class public Lchat/ola/vn/entry/b/c;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/view/LayoutInflater;Lchat/ola/vn/message/d;S)Landroid/view/View;
    .locals 5

    const v0, 0x7f0b0045

    const v1, 0x7f0b0185

    const/4 v2, 0x2

    const v3, 0x7f0b00c5

    const/4 v4, 0x0

    packed-switch p2, :pswitch_data_0

    :pswitch_0
    return-object v4

    :pswitch_1
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_0

    goto :goto_0

    :cond_0
    const v1, 0x7f0b00c5

    :goto_0
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/s;

    const p1, 0x7f0b0039

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/s;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_2
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_1

    goto :goto_1

    :cond_1
    const v1, 0x7f0b00c5

    :goto_1
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/ae;

    const p1, 0x7f0b003e

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/ae;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_3
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_2

    goto :goto_2

    :cond_2
    const v1, 0x7f0b00c5

    :goto_2
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/af;

    const p1, 0x7f0b0040

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/af;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_4
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_3

    goto :goto_3

    :cond_3
    const v1, 0x7f0b00c5

    :goto_3
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/t;

    const p1, 0x7f0b003b

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/t;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_5
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_4

    goto :goto_4

    :cond_4
    const v1, 0x7f0b00c5

    :goto_4
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/ag;

    const p1, 0x7f0b0043

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/ag;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_6
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_5

    goto :goto_5

    :cond_5
    const v1, 0x7f0b00c5

    :goto_5
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/r;

    const p1, 0x7f0b003f

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/r;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_7
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_6

    goto :goto_6

    :cond_6
    const v1, 0x7f0b00c5

    :goto_6
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/e;

    const p1, 0x7f0b0041

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/e;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_8
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_7

    goto :goto_7

    :cond_7
    const v1, 0x7f0b00c5

    :goto_7
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/v;

    invoke-direct {p0, v4, v0}, Lchat/ola/vn/entry/b/v;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_9
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_8

    goto :goto_8

    :cond_8
    const v1, 0x7f0b00c5

    :goto_8
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/ai;

    invoke-direct {p0, v4, v0}, Lchat/ola/vn/entry/b/ai;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_a
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_9

    goto :goto_9

    :cond_9
    const v1, 0x7f0b00c5

    :goto_9
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/ai;

    invoke-direct {p0, v4, v0}, Lchat/ola/vn/entry/b/ai;-><init>(Landroid/view/View;I)V

    goto/16 :goto_e

    :pswitch_b
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_a

    goto :goto_a

    :cond_a
    const v1, 0x7f0b00c5

    :goto_a
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/u;

    const p1, 0x7f0b003d

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/u;-><init>(Landroid/view/View;I)V

    goto :goto_e

    :pswitch_c
    const p1, 0x7f0b003a

    invoke-virtual {p0, p1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/g;

    invoke-direct {p0, v4}, Lchat/ola/vn/entry/b/g;-><init>(Landroid/view/View;)V

    goto :goto_e

    :pswitch_d
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_b

    goto :goto_b

    :cond_b
    const v1, 0x7f0b00c5

    :goto_b
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/ah;

    const p1, 0x7f0b0044

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/ah;-><init>(Landroid/view/View;I)V

    goto :goto_e

    :pswitch_e
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_c

    goto :goto_c

    :cond_c
    const v1, 0x7f0b00c5

    :goto_c
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/ad;

    const p1, 0x7f0b0036

    invoke-direct {p0, v4, p1}, Lchat/ola/vn/entry/b/ad;-><init>(Landroid/view/View;I)V

    goto :goto_e

    :pswitch_f
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v2, :cond_d

    goto :goto_d

    :cond_d
    const v1, 0x7f0b00c5

    :goto_d
    invoke-virtual {p0, v1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/f;

    invoke-direct {p0, v4}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    goto :goto_e

    :pswitch_10
    const p1, 0x7f0b0042

    invoke-virtual {p0, p1, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    new-instance p0, Lchat/ola/vn/entry/b/d;

    invoke-direct {p0, v4}, Lchat/ola/vn/entry/b/d;-><init>(Landroid/view/View;)V

    :goto_e
    invoke-virtual {v4, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-object v4

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_10
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
